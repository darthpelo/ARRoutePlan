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
- (void)getPositionList:(NSString *)string success:(void(^)(id responsedData))success failure:(void(^)(id responsedData))failure;

@end
