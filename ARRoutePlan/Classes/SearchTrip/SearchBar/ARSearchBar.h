//
//  ARSearchBar.h
//  ARRoutePlan
//
//  Created by Alessio Roberto on 12/11/13.
//  Copyright (c) 2013 Alessio Roberto. All rights reserved.
//

#import <UIKit/UIKit.h>

#define MAX_SEARCH_LENGTH 20

@interface ARSearchBar : UIView <UISearchBarDelegate> {
    UISearchBar *_searchBar;
}

@property (nonatomic, strong) id <UISearchBarDelegate> searchBarDelegate;

- (void)resetSearchBarText;
- (NSString *)getSearchBarText;
- (BOOL)resignFirstResponder;

@end
