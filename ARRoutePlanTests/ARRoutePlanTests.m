//
//  ARRoutePlanTests.m
//  ARRoutePlanTests
//
//  Created by Alessio Roberto on 12/11/13.
//  Copyright (c) 2013 Alessio Roberto. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ARNetworkManagment.h"
#import "ARFindPosition.h"

@interface ARRoutePlanTests : XCTestCase

@end

@implementation ARRoutePlanTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testResearch
{
    // Set the flag to YES
    __block BOOL waitingForBlock = YES;
    
    ARNetworkManagment *netManager = [ARNetworkManagment sharedManager];
    
    [netManager getPositionList:@"milan" success:^(id responsedData) {
        // Set the flag to NO to break the loop
        waitingForBlock = NO;
        XCTAssertNil(responsedData, @"Error occured");
    } failure:^(id responsedData) {
        // Set the flag to NO to break the loop
        waitingForBlock = NO;
        XCTAssertFalse(TRUE, @"Attention! Error!");
    }];
    
    // Run the loop
    while(waitingForBlock) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode
                                 beforeDate:[NSDate dateWithTimeIntervalSinceNow:0.1]];
    }
}

- (void)testPositionFirst
{
    // Set the flag to YES
    __block BOOL waitingForBlock = YES;
    
    ARFindPosition *find = [ARFindPosition sharedManager];
    
    [find findNearestPosition:nil userCoord:CLLocationCoordinate2DMake(0.0f, 0.0f) success:^(id responsedData) {
        // Set the flag to NO to break the loop
        waitingForBlock = NO;
        XCTAssertNil(responsedData, @"Error occured");
    } failure:^(id responsedData) {
        // Set the flag to NO to break the loop
        waitingForBlock = NO;
        XCTAssertFalse(TRUE, @"Attention! Error!");
    }];
    
    // Run the loop
    while(waitingForBlock) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode
                                 beforeDate:[NSDate dateWithTimeIntervalSinceNow:0.1]];
    }
}

- (void)testPositionSecond
{
    // Set the flag to YES
    __block BOOL waitingForBlock = YES;
    
    ARFindPosition *find = [ARFindPosition sharedManager];
    
    [find findNearestPosition:nil userCoord:CLLocationCoordinate2DMake(0.0f, 0.0f) success:^(id responsedData) {
        // Set the flag to NO to break the loop
        waitingForBlock = NO;
        XCTAssertNil(responsedData, @"Error occured");
    } failure:^(id responsedData) {
        // Set the flag to NO to break the loop
        waitingForBlock = NO;
        XCTAssertFalse(TRUE, @"Attention! Error!");
    }];
    
    // Run the loop
    while(waitingForBlock) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode
                                 beforeDate:[NSDate dateWithTimeIntervalSinceNow:0.1]];
    }
}

@end
