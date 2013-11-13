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
    frame = CGRectMake(boundsX, 40, 270, 22);
    self.titleLabel.frame = frame;
    frame = CGRectMake(boundsX, 10, 80, 18);
    self.upperLabel.frame = frame;
}

- (void)setupViews {
    UIView *myContentView = self.contentView;
    [[myContentView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.titleLabel.textColor = UIColorFromRGB(0x373737);
    self.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold"size:18.0];
    self.titleLabel.backgroundColor = [UIColor clearColor];
    [myContentView addSubview:self.titleLabel];
    
    self.upperLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.upperLabel.textColor = UIColorFromRGB(0x373737);
    self.upperLabel.font = [UIFont fontWithName:@"Helvetica"size:14.0];
    self.upperLabel.backgroundColor = [UIColor clearColor];
    [myContentView addSubview:self.upperLabel];
}

- (void)refresh
{
    if (self.location != nil && self.location.length > 0)
        self.titleLabel.text = self.location;
    else
        self.titleLabel.text = @"";
    if ([self.reuseIdentifier isEqualToString:@"FromCell"]) {
        self.upperLabel.text = @"From";
    } else if ([self.reuseIdentifier isEqualToString:@"ToCell"]) {
        self.upperLabel.text = @"To";
    } else if ([self.reuseIdentifier isEqualToString:@"StartDateCell"]) {
        self.upperLabel.text = @"Start Date";
    } else {
        self.upperLabel.text = @"End Date";
    }
}

@end
