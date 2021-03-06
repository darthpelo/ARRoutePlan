//
//  ARViewController.h
//  ARRoutePlan
//
//  Created by Alessio Roberto on 12/11/13.
//  Copyright (c) 2013 Alessio Roberto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ARViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *formTableView;

@property (nonatomic, weak) IBOutlet UIButton *searchButton;

- (IBAction)searchButtonPressed:(id)sender;

@end
