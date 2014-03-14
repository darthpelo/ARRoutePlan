//
//  ARNetworkManagment.h
//  ARRoutePlan
//
//  Created by Alessio Roberto on 13/11/13.
//  Copyright (c) 2013 Alessio Roberto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

#define TIMEOUT_CONNECTION 10

@interface ARNetworkManagment : NSObject

+ (id)sharedManager;

/**
 *    Executes the search for locations using the user's query.
 *
 *    @param string  The user's query.
 *    @param success The block to be executed on the completion of a successful request. This block has no return value and takes an argument: the object constructed from the response data of the request.
 *    @param failure The block to be executed on the completion of an unsuccessful request. This block has no return value and takes an argument: the error that occurred during the request.
 */
- (void)getPositionList:(NSString *)string success:(void(^)(id responsedData))success failure:(void(^)(id responsedData))failure;

@end
