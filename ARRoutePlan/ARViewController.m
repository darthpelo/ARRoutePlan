//
//  ARViewController.m
//  ARRoutePlan
//
//  Created by Alessio Roberto on 12/11/13.
//  Copyright (c) 2013 Alessio Roberto. All rights reserved.
//

#import "ARViewController.h"
#import "ARLocationCell.h"
#import "ARDateCell.h"
#import "ARSearchViewController.h"
#import "ARCalendarViewController.h"

@interface ARViewController () {
    NSString *startTrip;
    NSString *endTrip;
    NSString *startTripDate;
    NSString *endTripDate;
    
    ARSearchViewController *searchViewController;
    ARCalendarViewController *calendarViewController;
}

@end

@implementation ARViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)searchButtonPressed:(id)sender
{
    if (!startTrip || !endTrip || !startTripDate || !endTripDate) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Attention"
                                                        message:@"You must fill in all fields!"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil
                              ];
        [alert show];
    } else {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Attention"
                                                    message:@"The search function isn't yet ready... :("
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil
                          ];
    [alert show];
    }
}

- (void)setStartPosition:(NSDictionary *)pos
{
    startTrip = pos[@"name"];
    [self.formTableView reloadData];
}

- (void)setEndPosition:(NSDictionary *)pos
{
    endTrip = pos[@"name"];
    [self.formTableView reloadData];
}

- (void)setStartDate:(NSString *)date
{
    startTripDate = date;
    [self.formTableView reloadData];
}

- (void)setEndDate:(NSString *)date
{
    endTripDate = date;
    [self.formTableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    
    if (row == 0) {
        ARLocationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FromCell"];
        if (cell == nil) {
            cell = [[ARLocationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FromCell"];
            [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
            [cell setSelectionStyle:UITableViewCellSelectionStyleBlue];
        }
        
        cell.location = startTrip;
        return cell;
    } else if (row == 1) {
        ARLocationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ToCell"];
        if (cell == nil) {
            cell = [[ARLocationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ToCell"];
            [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
            [cell setSelectionStyle:UITableViewCellSelectionStyleBlue];
        }
        
        cell.location = endTrip;
        return cell;
    } else if (row == 2) {
        ARLocationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StartDateCell"];
        if (cell == nil) {
            cell = [[ARLocationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"StartDateCell"];
            [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
            [cell setSelectionStyle:UITableViewCellSelectionStyleBlue];
        }
        cell.location = startTripDate;
        return cell;
    } else {
        ARLocationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EndDateCell"];
        if (cell == nil) {
            cell = [[ARLocationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"EndDateCell"];
            [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
            [cell setSelectionStyle:UITableViewCellSelectionStyleBlue];
        }
        cell.location = endTripDate;
        return cell;
    }
}

#pragma mark - Table view cell selection

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    
    switch (row) {
        case 0:{
            if (searchViewController == nil) {
                searchViewController = [[ARSearchViewController alloc] init];
            }
            __weak ARViewController *wSelf = self;
            searchViewController.selectPosition = ^(NSDictionary *position){
                [wSelf setStartPosition:position];
            };
            [self presentViewController:searchViewController animated:YES completion:^{
                [tableView deselectRowAtIndexPath:indexPath animated:YES];
            }];
            break;
        }
        case 1:{
            if (searchViewController == nil) {
                searchViewController = [[ARSearchViewController alloc] init];
            }
            __weak ARViewController *wSelf = self;
            searchViewController.selectPosition = ^(NSDictionary *position){
                [wSelf setEndPosition:position];
            };
            [self presentViewController:searchViewController animated:YES completion:^{
                [tableView deselectRowAtIndexPath:indexPath animated:YES];
            }];
            break;
        }
        case 2:{
            if (calendarViewController == nil) {
                calendarViewController = [[ARCalendarViewController alloc] init];
            }
            __weak ARViewController *wSelf = self;
            calendarViewController.selectDate = ^(NSString *selectDate){
                [wSelf setStartDate:selectDate];
            };
            [self presentViewController:calendarViewController animated:YES completion:^{
                [tableView deselectRowAtIndexPath:indexPath animated:YES];
            }];
            break;
        }
        case 3:{
            if (calendarViewController == nil) {
                calendarViewController = [[ARCalendarViewController alloc] init];
            }
            __weak ARViewController *wSelf = self;
            calendarViewController.selectDate = ^(NSString *selectDate){
                [wSelf setEndDate:selectDate];
            };
            [self presentViewController:calendarViewController animated:YES completion:^{
                [tableView deselectRowAtIndexPath:indexPath animated:YES];
            }];
            break;
        }
    }
}

@end
