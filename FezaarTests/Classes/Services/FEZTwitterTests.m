//
//  FEZTwitterTests.m
//  Fezaar
//
//  Created by t-matsumura on 3/21/15.
//  Copyright (c) 2015 HumourStudio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "FEZTwitter.h"

@interface FEZTwitterTests : XCTestCase

@property (nonatomic) FEZTwitter *sut;

@end

@implementation FEZTwitterTests

- (void)setUp {
    [super setUp];
    
    _sut = [[FEZTwitter alloc] init];
}

- (void)testAuthorize {
    XCTestExpectation *expectation = [self expectationWithDescription:@"should receive access token"];
    
    [[self.sut authorize] subscribeNext:^(ACAccount *account) {
        [expectation fulfill];
        
        NSLog(@"Authorized with account: %@", account);
        
    } error:^(NSError *error) {
        XCTFail(@"should not fail with error: %@", error);
    }];
    
    [self waitForExpectationsWithTimeout:5 handler:nil];
}

- (void)testFetchHomeTimeline {
    XCTestExpectation *expectation = [self expectationWithDescription:@"should receive home timeline"];
    
    [[self.sut fetchHomeTimeline] subscribeNext:^(FEZTimeline *timeline) {
        [expectation fulfill];
        
        XCTAssert(timeline.tweets.count > 0, @"should receive at least 1 tweet");
        
        NSLog(@"Fetched home timeline with tweets: %@, count: %lu", timeline.tweets, (unsigned long)timeline.tweets.count);
        
    } error:^(NSError *error) {
        XCTFail(@"should not fail with error: %@", error);
    }];
    
    [self waitForExpectationsWithTimeout:5 handler:nil];
}

@end