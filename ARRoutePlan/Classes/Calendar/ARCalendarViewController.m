//
//  ARCalendarViewController.m
//  ARRoutePlan
//
//  Created by Alessio Roberto on 13/11/13.
//  Copyright (c) 2013 Alessio Roberto. All rights reserved.
//

#import "ARCalendarViewController.h"

@interface ARCalendarViewController ()

@end

@implementation ARCalendarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    MNCalendarView *calendarView = [[MNCalendarView alloc] initWithFrame:self.view.bounds];
    calendarView.calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    calendarView.selectedDate = [NSDate date];
    calendarView.delegate = self;
    calendarView.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:calendarView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - MNCalendarViewDelegate

- (void)calendarView:(MNCalendarView *)calendarView didSelectDate:(NSDate *)date {
    NSTimeInterval secondsInOneHour= 1 * 60 * 60;
    NSDate *dateOneHourAhead = [date dateByAddingTimeInterval:secondsInOneHour];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM/dd/yy"];
    
    NSString *stringFromDate = [formatter stringFromDate:dateOneHourAhead];
    
    self.selectDate(stringFromDate);
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)calendarView:(MNCalendarView *)calendarView shouldSelectDate:(NSDate *)date {
    NSTimeInterval timeInterval = [date timeIntervalSinceDate:[NSDate date]];
    
    if (timeInterval < 0) {
        return NO;
    }
    
    return YES;
}

@end
