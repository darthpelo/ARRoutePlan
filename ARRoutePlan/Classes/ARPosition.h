//
//  ARPosition.h
//  ARRoutePlan
//
//  Created by Alessio Roberto on 16/11/13.
//  Copyright (c) 2013 Alessio Roberto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ARPosition : NSObject

@property (assign) long positionId;
@property (nonatomic, strong) NSString *name;
@property (assign) double distance;

/**
 *    New ARPosition istance.
 *
 *    @param dic The JSON of a destination.
 *
 *    @return ARPosition object.
 */
- (id)initWithDictionary:(NSDictionary *)dic;

@end
