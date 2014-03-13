//
//  ARSearchBar.h
//  ARRoutePlan
//
//  Created by Alessio Roberto on 12/11/13.
//  Copyright (c) 2013 Alessio Roberto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

#define MAX_SEARCH_LENGTH 20

@protocol ARSearchBarDelegate <NSObject>

@required
- (void)newDestinationsRequest:(NSString *)request;
- (void)closeButton;

@end

@interface ARSearchBar : UIView <UISearchBarDelegate, MBProgressHUDDelegate>

@property (nonatomic, strong) id <ARSearchBarDelegate> searchBarDelegate;

- (void)resetSearchBarText;

@end
