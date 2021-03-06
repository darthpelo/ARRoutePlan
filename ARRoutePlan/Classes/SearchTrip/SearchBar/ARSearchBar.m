//
//  ARSearchBar.m
//  ARRoutePlan
//
//  Created by Alessio Roberto on 12/11/13.
//  Copyright (c) 2013 Alessio Roberto. All rights reserved.
//

#import "ARSearchBar.h"
#import "UIControl+MTControl.h"

@interface ARSearchBar () {
    UISearchBar *_searchBar;
}

@end

@implementation ARSearchBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _searchBar = [[UISearchBar alloc]initWithFrame:CGRectZero];
        _searchBar.frame = CGRectMake(0, 0, 260, 46);
        _searchBar.barTintColor = UIColorFromRGB(0x427CA1);
        _searchBar.tintColor = UIColorFromRGB(0x427CA1);
        _searchBar.backgroundColor = UIColorFromRGB(0x427CA1);
        
        UIButton *cancellBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        cancellBtn.frame = CGRectMake(260, 0, 60, 46);
        [cancellBtn setBackgroundColor:UIColorFromRGB(0x427CA1)];
        [cancellBtn setTitle:@"Close" forState:UIControlStateNormal];
        [cancellBtn touchUpInside:^(UIEvent *event) {
            [_searchBarDelegate closeButton];
            [self resetSearchBarText];
        }];
        cancellBtn.tintColor = [UIColor whiteColor];
        [self addSubview:cancellBtn];
        
        _searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
        _searchBar.placeholder = @"Enter your destination";
        _searchBar.delegate = self;
        [self addSubview:_searchBar];
    }
    
    return self;
}

- (BOOL)becomeFirstResponder
{
    return [_searchBar becomeFirstResponder];
}

- (BOOL)resignFirstResponder
{
    return [_searchBar resignFirstResponder];
}

#pragma mark - SearchBar Delegate

- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    NSUInteger newLength = [searchBar.text length] + [text length] - range.length;
    return (newLength > MAX_SEARCH_LENGTH) ? NO : YES;
}

- (void)resetSearchBarText
{
    _searchBar.text = @"";
}


- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [self resetSearchBarText];
    
    [_searchBarDelegate closeButton];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{

}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [_searchBar resignFirstResponder];
    
    [_searchBarDelegate newDestinationsRequest:searchBar.text];
}

@end
