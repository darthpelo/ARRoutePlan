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

@interface ARViewController () {
    NSString *startTrip;
    NSString *endTrip;
    NSDate *startTripDate;
    NSDate *endTripDate;
}

@end

@implementation ARViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)searchButtonPressed:(id)sende
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Attention"
                                                    message:@"Search function isn't impelement yet"
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil
                          ];
    [alert show];
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
    int row = indexPath.row;
    
    if (row == 0) {
        ARLocationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FromCell"];
        if (cell == nil) {
            cell = [[ARLocationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FromCell"];
            [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        }
        
        cell.location = startTrip;
        return cell;
    } else if (row == 1) {
        ARLocationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ToCell"];
        if (cell == nil) {
            cell = [[ARLocationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ToCell"];
            [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        }
        
        cell.location = endTrip;
        return cell;
    } else {
        ARLocationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
        if (cell == nil) {
            cell = [[ARLocationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
            [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        }
        
        return cell;
    }
}

@end
