//
//  ARLocationCell.m
//  ARRoutePlan
//
//  Created by Alessio Roberto on 12/11/13.
//  Copyright (c) 2013 Alessio Roberto. All rights reserved.
//

#import "ARLocationCell.h"

@implementation ARLocationCell

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self setupViews];
    [self refresh];
    
    CGRect contentRect = self.contentView.bounds;
    CGFloat boundsX = contentRect.origin.x + 20;
    CGRect frame;
    frame = CGRectMake(boundsX, 10, 280, 18);
    self.titleLabel.frame = frame;
}

- (void)setupViews {
    UIView *myContentView = self.contentView;
    [[myContentView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.titleLabel.textColor = UIColorFromRGB(0x373737);
    self.titleLabel.highlightedTextColor = [UIColor whiteColor];
    self.titleLabel.font = [UIFont fontWithName:@"Helvetica"size:15.0];
    self.titleLabel.backgroundColor = [UIColor blueColor];
//    if (SYSTEM_VERSION_LESS_THAN(@"7.0"))
//        self.titleLabel.backgroundColor = [UIColor clearColor];
    
    [myContentView addSubview:self.titleLabel];
}

- (void)refresh
{
    if (self.location != nil && self.location.length > 0)
        self.titleLabel.text = self.location;
    else
        self.titleLabel.text = @"";
}

@end
