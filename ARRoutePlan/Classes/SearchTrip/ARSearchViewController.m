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

@interface ARSearchViewController () {
    ARSearchBar *searchView;
    UITableView *_tableView;
    NSMutableArray *_tagsInSearch;
    
    NSMutableArray *positionList;
    
    BOOL positionsListReady;
    BOOL serverRequestEnd;
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
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
	
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

    [self.view addSubview:_tableView];
    
    positionList = [[NSMutableArray alloc] init];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark SearchBar delegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if ([searchView getSearchBarText].length == 3 && serverRequestEnd) {
        serverRequestEnd = NO;
        ARNetworkManagment *netManager = [ARNetworkManagment sharedManager];
        [netManager getPositionList:[searchView getSearchBarText] success:^(id responsedData) {
            NSLog(@"%@", responsedData);
            ARFindPosition *finder = [ARFindPosition sharedManager];
            [finder findNearestPosition:responsedData success:^(id responsedData) {
                positionList = [[NSMutableArray alloc] initWithArray:responsedData];
                serverRequestEnd = YES;
                positionsListReady = YES;
            } failure:^(id responsedData) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Attention!" message:@"Error occured!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                serverRequestEnd = YES;
                positionsListReady = NO;
            }];
        } failure:^(id responsedData) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Attention!" message:@"Network Problem!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            serverRequestEnd = YES;
            positionsListReady = NO;
        }];
    } else if ([searchView getSearchBarText].length > 3 && positionsListReady) {
        ARFindPosition *finder = [ARFindPosition sharedManager];
        [finder findNearestPosition:positionList success:^(id responsedData) {
            positionList = [[NSMutableArray alloc] initWithArray:responsedData];
        } failure:^(id responsedData) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Attention!" message:@"Error occured!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            positionsListReady = NO;
        }];
    }

    [_tableView reloadData];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self dismissViewControllerAnimated:YES completion:^(void){
        [positionList removeAllObjects];
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
    return positionList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        [cell setAccessoryType:UITableViewCellAccessoryNone];
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
