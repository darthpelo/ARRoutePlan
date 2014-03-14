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

/**
 *    Reorder a list of locations by user position.
 *
 *    @param positions The list of locations
 *    @param coord     User coordinate
 *    @param success   The block to be executed on the completion of a successful request. This block has no return value and takes an argument: the object constructed from the response data of the request.
 *    @param failure   The block to be executed on the completion of an unsuccessful request. This block has no return value and takes an argument: the error that occurred during the request.
 */
- (void)findNearestPosition:(NSMutableArray *)positions userCoord:(CLLocationCoordinate2D)coord success:(void(^)(id responsedData))success failure:(void(^)(id responsedData))failure;

@end
