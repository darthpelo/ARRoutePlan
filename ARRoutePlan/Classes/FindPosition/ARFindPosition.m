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

- (void)findNearestPosition:(NSMutableArray *)positions userCoord:(CLLocationCoordinate2D)coord success:(void(^)(id responsedData))success failure:(void(^)(id responsedData))failure
{
    NSMutableArray *newPositions = [[NSMutableArray alloc] init];
    for (NSDictionary *position in positions) {
        double lat = [position[@"geo_position"][@"latitude"] doubleValue];
        double lon = [position[@"geo_position"][@"longitude"] doubleValue];
        CLLocationCoordinate2D positionCoord = CLLocationCoordinate2DMake(lat, lon);
        CLLocation *a = [[CLLocation alloc] initWithLatitude:coord.latitude longitude:coord.longitude];
        CLLocation *b = [[CLLocation alloc] initWithLatitude:positionCoord.latitude longitude:positionCoord.longitude];
        double distance = [a distanceFromLocation:b];
        NSMutableDictionary *newPosition = [NSMutableDictionary dictionaryWithDictionary:position];
        [newPosition setObject:[NSNumber numberWithDouble:distance] forKey:@"distance"];
        [newPositions addObject:newPosition];
    }
    
    NSArray *sorted = [newPositions sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"distance" ascending:YES]]];
    success(sorted);
}

- (void)filterPositions:(NSArray *)positions byString:(NSString *)string result:(void (^)(id))block
{
    // Suddivido chiave di ricerca
    NSString *key = [string lowercaseString];
    NSArray *tokens = [key componentsSeparatedByString:@" "];
    
    // Inserisco in un array le stringhe contenenti i nomi dei tag
    NSMutableArray *tmp = [NSMutableArray array];
    for (NSDictionary *pos in positions) {
        NSString *lcPosName = [pos[@"name"] lowercaseString];
        [tmp addObject:lcPosName];
    }
    
    // Ricorsivamente filtro l'array con le sotto stringhe della chiave di ricerca
    for (NSString *str in tokens) {
        if (![str isEqualToString:@""])
            tmp = (NSMutableArray *)[tmp filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF contains[cd] %@",str]];
    }
    
    // Inserisco nella lista dei tag trovati i tag il cui nome è presente nell'array filtrato
    NSMutableArray *result = [NSMutableArray array];
    for (NSString *name in tmp) {
        for (NSDictionary *pos in positions) {
            if ([name isEqualToString:[pos[@"name"] lowercaseString]])
                [result addObject:pos];
        }
    }
    
    block(result);
}

@end
