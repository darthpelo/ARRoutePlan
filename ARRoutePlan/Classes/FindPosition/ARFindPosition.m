//
//  ARFindPosition.m
//  ARRoutePlan
//
//  Created by Alessio Roberto on 13/11/13.
//  Copyright (c) 2013 Alessio Roberto. All rights reserved.
//

#import "ARFindPosition.h"

@implementation ARFindPosition

+ (id)sharedManager {
    static ARFindPosition *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (void)findNearestPosition:(NSMutableArray *)positions success:(void(^)(id responsedData))success failure:(void(^)(id responsedData))failure
{
    
}

@end
