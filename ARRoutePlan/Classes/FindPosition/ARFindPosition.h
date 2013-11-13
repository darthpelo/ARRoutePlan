//
//  ARFindPosition.h
//  ARRoutePlan
//
//  Created by Alessio Roberto on 13/11/13.
//  Copyright (c) 2013 Alessio Roberto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ARFindPosition : NSObject

+ (id)sharedManager;
- (void)findNearestPosition:(NSMutableArray *)positions success:(void(^)(id responsedData))success failure:(void(^)(id responsedData))failure;

@end
