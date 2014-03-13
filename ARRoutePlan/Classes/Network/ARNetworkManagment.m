//
//  ARNetworkManagment.m
//  ARRoutePlan
//
//  Created by Alessio Roberto on 13/11/13.
//  Copyright (c) 2013 Alessio Roberto. All rights reserved.
//

#import "ARNetworkManagment.h"
#import "NSString+Extra.h"

@implementation ARNetworkManagment

#pragma mark Singleton Methods

+ (id)sharedManager {
    static ARNetworkManagment *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (void)getPositionList:(NSString *)string success:(void (^)(id))success failure:(void (^)(id))failure
{
    AFNetworkActivityIndicatorManager * newactivity = [[AFNetworkActivityIndicatorManager alloc] init];
    newactivity.enabled = YES;
    
    NSString *urlString = [NSString stringWithFormat:@"https://api.goeuro.com/api/v2/position/suggest/en/%@", [string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    [request setTimeoutInterval:TIMEOUT_CONNECTION];
    
    AFJSONRequestOperation *reqOperation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        success(JSON[@"results"]);
        newactivity.enabled = NO;
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        failure(error);
        newactivity.enabled = NO;
    }];
    [reqOperation start];
}

@end
