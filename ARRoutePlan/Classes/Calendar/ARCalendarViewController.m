//
//  ARCalendarViewController.m
//  ARRoutePlan
//
//  Created by Alessio Roberto on 13/11/13.
//  Copyright (c) 2013 Alessio Roberto. All rights reserved.
//

#import "ARCalendarViewController.h"
#import "UIControl+MTControl.h"

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
    [self.view setBackgroundColor:UIColorFromRGB(0x427CA1)];
    
    CGRect calendarFrame = CGRectMake(0, 64, 320, self.view.bounds.size.height - 64);
    MNCalendarView *calendarView = [[MNCalendarView alloc] initWithFrame:calendarFrame];
    calendarView.calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    calendarView.selectedDate = [NSDate date];
    calendarView.delegate = self;
    calendarView.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:calendarView];
    
    UIButton *cancellBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    cancellBtn.frame = CGRectMake(260, 20, 60, 44);
    [cancellBtn setTitle:@"Close" forState:UIControlStateNormal];
    [cancellBtn touchUpInside:^(UIEvent *event) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    cancellBtn.tintColor = [UIColor whiteColor];
    [self.view addSubview:cancellBtn];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 20, 200, 44)];
    titleLabel.text = @"Choose the day";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titleLabel];
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
    [formatter setDateFormat:@"MM-dd-yyyy"];
    
    NSString *stringFromDate = [formatter stringFromDate:dateOneHourAhead];
    
    self.selectDate(stringFromDate);
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)calendarView:(MNCalendarView *)calendarView shouldSelectDate:(NSDate *)date {
    NSTimeInterval timeInterval = [date timeIntervalSinceDate:[NSDate date]];
    
    if (timeInterval < -5000) {
        return NO;
    }
    
    return YES;
}

@end
