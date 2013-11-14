//
//  ARSearchViewController.m
//  ARRoutePlan
//
//  Created by Alessio Roberto on 12/11/13.
//  Copyright (c) 2013 Alessio Roberto. All rights reserved.
//

#import "ARSearchViewController.h"
#import "ARSearchBar.h"
#import "ARNetworkManagment.h"
#import "ARFindPosition.h"

#define KEYBOARD_OPEN 216.0f

@interface ARSearchViewController () {
    ARSearchBar *searchView;
    UITableView *_tableView;
    NSMutableArray *_tagsInSearch;
    MBProgressHUD *HUD;
    
    NSArray *_positionsList;
    NSMutableArray *_positionsInSearch;
    
    BOOL positionsListReady;
    BOOL serverRequestEnd;
    
    CLLocationManager *_locationManager;
}

@end

@implementation ARSearchViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        positionsListReady = NO;
        serverRequestEnd = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setBackgroundColor:UIColorFromRGB(0x427CA1)];
	
    searchView = [[ARSearchBar alloc] initWithFrame:CGRectMake(0, 20, 320, 46)];
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,
                                                               searchView.frame.size.height + searchView.frame.origin.y,
                                                               320,
                                                               (screenHeight == 568.0f) ? (568 - (searchView.frame.size.height + searchView.frame.origin.y)) : (480 - (searchView.frame.size.height + searchView.frame.origin.y))
                                                               )
                                              style:UITableViewStylePlain
                  ];
    searchView.searchBarDelegate = self;
    [self.view addSubview:searchView];
    [searchView becomeFirstResponder];
    
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [_tableView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:_tableView];
    
    // LocationManager
	_locationManager = [[CLLocationManager alloc] init];
    _locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    _locationManager.distanceFilter = 200;
    _locationManager.delegate = self;
    [_locationManager startUpdatingLocation];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [searchView becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    [_locationManager stopUpdatingLocation];
}


#pragma mark - SearchBar delegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if ([searchView getSearchBarText].length == 2 && serverRequestEnd && !positionsListReady) {
        // Fake view for MOProgressHUD
        CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
        float fakeH = (screenHeight == 568.0f) ? 568 - KEYBOARD_OPEN : 480 - KEYBOARD_OPEN;
        UIView *fakeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, fakeH)];
        [_tableView addSubview:fakeView];
        
        HUD = [[MBProgressHUD alloc] initWithView:fakeView];
        [fakeView addSubview:HUD];
        HUD.delegate = self;
        [HUD show:YES];
        serverRequestEnd = NO;
        ARNetworkManagment *netManager = [ARNetworkManagment sharedManager];
        [netManager getPositionList:[[searchView getSearchBarText] lowercaseString] success:^(id responsedData) {
            ARFindPosition *finder = [ARFindPosition sharedManager];
            [finder findNearestPosition:responsedData userCoord:(CLLocationCoordinate2D)_locationManager.location.coordinate success:^(id responsedData) {
                _positionsList = [[NSArray alloc] initWithArray:responsedData];
                _positionsInSearch = [NSMutableArray arrayWithArray:_positionsList];
                serverRequestEnd = YES;
                positionsListReady = YES;
                [_tableView reloadData];
                [HUD hide:YES];
                [fakeView removeFromSuperview];
            } failure:^(id responsedData) {
                [HUD hide:YES];
                [fakeView removeFromSuperview];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Attention!" message:@"Error occured!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                serverRequestEnd = YES;
                positionsListReady = NO;
            }];
        } failure:^(id responsedData) {
            [HUD hide:YES];
            [fakeView removeFromSuperview];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Attention!" message:@"Network Problem!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            serverRequestEnd = YES;
            positionsListReady = NO;
        }];
    } else if ([searchView getSearchBarText].length >= 2 && positionsListReady) {
        ARFindPosition *finder = [ARFindPosition sharedManager];
        [finder filterPositions:_positionsList byString:[searchView getSearchBarText] result:^(id responsedData) {
            _positionsInSearch = [NSMutableArray arrayWithArray:responsedData];
            [_tableView reloadData];
        }];
    } else if (positionsListReady && [searchView getSearchBarText].length < 2) {
        [_positionsInSearch removeAllObjects];
        _positionsList = nil;
        positionsListReady = NO;
        serverRequestEnd = YES;
        [_tableView reloadData];
    }
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    if ([searchView getSearchBarText].length > 2 && positionsListReady) {
        ARFindPosition *finder = [ARFindPosition sharedManager];
        [finder filterPositions:_positionsList byString:[searchView getSearchBarText] result:^(id responsedData) {
            _positionsInSearch = [NSMutableArray arrayWithArray:responsedData];
            [_tableView reloadData];
        }];
    }
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self dismissViewControllerAnimated:YES completion:^(void){
        _positionsList = nil;
        [_positionsInSearch removeAllObjects];
        [_tableView reloadData];
        [searchView resetSearchBarText];
    }];
}

#pragma mark - UIScrollDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [searchView resignFirstResponder];
}

#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _positionsInSearch.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        [cell setAccessoryType:UITableViewCellAccessoryNone];
    }
    
    NSDictionary *position = [_positionsInSearch objectAtIndex:indexPath.row];
    cell.textLabel.text = position[@"name"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectPosition([_positionsInSearch objectAtIndex:indexPath.row]);
    [self dismissViewControllerAnimated:YES completion:^{
        [_positionsInSearch removeAllObjects];
        [_tableView reloadData];
        [searchView resetSearchBarText];
    }];
}

@end
