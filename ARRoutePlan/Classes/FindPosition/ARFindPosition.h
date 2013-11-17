//
//  ARFindPosition.h
//  ARRoutePlan
//
//  Created by Alessio Roberto on 13/11/13.
//  Copyright (c) 2013 Alessio Roberto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface ARFindPosition : NSObject

+ (id)sharedManager;

- (void)findNearestPosition:(NSMutableArray *)positions userCoord:(CLLocationCoordinate2D)coord success:(void(^)(id responsedData))success failure:(void(^)(id responsedData))failure;

- (void)filterPositions:(NSArray *)positions byString:(NSString *)string result:(void(^)(id responsedData))block;

- (NSMutableArray *)convert:(NSArray *)positions;

@end
