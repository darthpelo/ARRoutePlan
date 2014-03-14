//
//  ARSearchViewController.h
//  ARRoutePlan
//
//  Created by Alessio Roberto on 12/11/13.
//  Copyright (c) 2013 Alessio Roberto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "MBProgressHUD.h"
#import "ARPosition.h"
#import "ARSEarchBar.h"

@interface ARSearchViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate, CLLocationManagerDelegate, ARSearchBarDelegate, MBProgressHUDDelegate>

/**
 *    Callback that returns the position chosed by the user.
 */
@property (copy) void (^selectPosition)(ARPosition *position);

@end
