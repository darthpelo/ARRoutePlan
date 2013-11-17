//
//  ARPosition.m
//  ARRoutePlan
//
//  Created by Alessio Roberto on 16/11/13.
//  Copyright (c) 2013 Alessio Roberto. All rights reserved.
//

#import "ARPosition.h"

@implementation ARPosition

- (id)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.name = dic[@"name"];
        self.positionId = [dic[@"_id"] longValue];
        self.distance = [dic[@"distance"] doubleValue];
    }
    return self;
}

@end
