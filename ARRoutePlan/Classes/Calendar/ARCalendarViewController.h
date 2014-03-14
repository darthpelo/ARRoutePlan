//
//  ARCalendarViewController.h
//  ARRoutePlan
//
//  Created by Alessio Roberto on 13/11/13.
//  Copyright (c) 2013 Alessio Roberto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MNCalendarView.h"

@interface ARCalendarViewController : UIViewController <MNCalendarViewDelegate>

/**
 *    Callback that returns the date chosen by the user.
 */
@property (copy) void (^selectDate)(NSString *date);

@end
