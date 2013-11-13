//
//  ARSearchBar.m
//  ARRoutePlan
//
//  Created by Alessio Roberto on 12/11/13.
//  Copyright (c) 2013 Alessio Roberto. All rights reserved.
//

#import "ARSearchBar.h"
#import "UIControl+MTControl.h"

@implementation ARSearchBar
@synthesize searchBarDelegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        _searchBar = [[UISearchBar alloc]initWithFrame:CGRectZero];
        

            _searchBar.frame = CGRectMake(0, 0, 320, 46);
            _searchBar.barTintColor = [UIColor whiteColor];
            _searchBar.tintColor = UIColorFromRGB(0x1D7800);
            _searchBar.backgroundColor = [UIColor whiteColor];
            
            UIButton *cancellBtn = [UIButton buttonWithType:UIButtonTypeSystem];
            cancellBtn.frame = CGRectMake(240, 0, 70, 46);
            [cancellBtn setBackgroundColor:[UIColor whiteColor]];
            [cancellBtn setTitle:@"Close" forState:UIControlStateNormal];
            [cancellBtn touchUpInside:^(UIEvent *event) {
                [searchBarDelegate searchBarCancelButtonClicked:_searchBar];
                [self resetSearchBarText];
            }];
            cancellBtn.tintColor = UIColorFromRGB(0x1D7800);
            [self addSubview:cancellBtn];

//        [[UISearchBar appearance] setSearchFieldBackgroundImage:[] forState:UIControlStateNormal];
        _searchBar.autocorrectionType = UITextAutocorrectionTypeDefault;
        _searchBar.placeholder = @"";
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

- (NSString *)getSearchBarText
{
    return _searchBar.text;
}

-(void)setSearchBarDelegate:(id<UISearchBarDelegate>)searchBarDelegate_{
    searchBarDelegate = searchBarDelegate_;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [searchBarDelegate searchBarCancelButtonClicked:_searchBar];
    [self resetSearchBarText];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    [searchBarDelegate searchBar:searchBar textDidChange:searchText];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [_searchBar resignFirstResponder];
}

@end
