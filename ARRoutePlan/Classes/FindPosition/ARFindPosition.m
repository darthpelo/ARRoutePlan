//
//  ARFindPosition.m
//  ARRoutePlan
//
//  Created by Alessio Roberto on 13/11/13.
//  Copyright (c) 2013 Alessio Roberto. All rights reserved.
//

#import "ARFindPosition.h"
#import "ARPosition.h"

@implementation ARFindPosition

+ (id)sharedManager {
    static ARFindPosition *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (void)findNearestPosition:(NSMutableArray *)positions userCoord:(CLLocationCoordinate2D)coord success:(void(^)(id responsedData))success failure:(void(^)(id responsedData))failure
{
    NSMutableArray *newPositions = [[NSMutableArray alloc] init];
    for (NSDictionary *position in positions) {
        CLLocationCoordinate2D positionCoord = CLLocationCoordinate2DMake([position[@"geo_position"][@"latitude"] doubleValue],
                                                                          [position[@"geo_position"][@"longitude"] doubleValue]
                                                                          );
        
        CLLocation *currentLoc = [[CLLocation alloc] initWithLatitude:coord.latitude longitude:coord.longitude];
        CLLocation *posLoc = [[CLLocation alloc] initWithLatitude:positionCoord.latitude longitude:positionCoord.longitude];
        double distance = [currentLoc distanceFromLocation:posLoc];
        
        NSMutableDictionary *newPosition = [NSMutableDictionary dictionaryWithDictionary:position];
        [newPosition setObject:[NSNumber numberWithDouble:distance] forKey:@"distance"];
        [newPositions addObject:newPosition];
    }
    
    // Sorted newPositions array, by distance, in ascending order
    NSArray *sorted = [newPositions sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"distance" ascending:YES]]];
    success([self convert:sorted]);
}

- (NSMutableArray *)convert:(NSArray *)positions
{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    for (NSDictionary *dic in positions) {
        ARPosition *pos = [[ARPosition alloc] initWithDictionary:dic];
        [result addObject:pos];
    }
    return result;
}

@end
