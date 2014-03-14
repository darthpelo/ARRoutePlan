//
//  ARSearchViewController.m
//  ARRoutePlan
//
//  Created by Alessio Roberto on 12/11/13.
//  Copyright (c) 2013 Alessio Roberto. All rights reserved.
//

#import "ARSearchViewController.h"
#import "ARNetworkManagment.h"
#import "ARFindPosition.h"
#import "ARNetworkManagment.h"
#import "ARFindPosition.h"

#define KEYBOARD_OPEN 216.0f

@interface ARSearchViewController () {
    ARSearchBar *searchView;
    UITableView *_tableView;
    NSMutableArray *_tagsInSearch;
    MBProgressHUD *HUD;

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
    searchView.searchBarDelegate = self;
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

#pragma mark - ARSearchBar delegate

- (void)newDestinationsRequest:(NSString *)request
{
    // Fake view for MBProgressHUD
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
//    float fakeH = (screenHeight == 568.0f) ? 568 - KEYBOARD_OPEN : 480 - KEYBOARD_OPEN;
    UIView *fakeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, screenHeight)];
    [_tableView addSubview:fakeView];
    
    HUD = [[MBProgressHUD alloc] initWithView:fakeView];
    [fakeView addSubview:HUD];
    HUD.delegate = self;
    
    ARNetworkManagment *netManager = [ARNetworkManagment sharedManager];
    
    // get position from server with the first two letters
    [netManager getPositionList:[request lowercaseString] success:^(id responsedData) {
        ARFindPosition *finder = [ARFindPosition sharedManager];
        
        // reorder position by distance
        [finder findNearestPosition:responsedData userCoord:(CLLocationCoordinate2D)_locationManager.location.coordinate success:^(id responsedData) {
            // ordered list is ready
            _positionsInSearch = [NSMutableArray arrayWithArray:responsedData];
            [_tableView reloadData];
            
            [HUD hide:YES];
            [fakeView removeFromSuperview];
        } failure:^(id responsedData) {
            [HUD hide:YES];
            [fakeView removeFromSuperview];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Attention!" message:@"Error occured!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }];
    } failure:^(id responsedData) {
        [HUD hide:YES];
        [fakeView removeFromSuperview];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Attention!" message:@"Network Problem!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }];
}

- (void)closeButton
{
    [self dismissViewControllerAnimated:YES completion:^(void){
        [_positionsInSearch removeAllObjects];
        _positionsInSearch = nil;
        [_tableView reloadData];
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
    
    ARPosition *position = [_positionsInSearch objectAtIndex:indexPath.row];
    cell.textLabel.text = position.name;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectPosition([_positionsInSearch objectAtIndex:indexPath.row]);
    [self dismissViewControllerAnimated:YES completion:^{
        [searchView resetSearchBarText];
        [_positionsInSearch removeAllObjects];
        [_tableView reloadData];
    }];
}

@end
