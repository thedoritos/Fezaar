//
//  FEZTwitter.m
//  Fezaar
//
//  Created by t-matsumura on 3/21/15.
//  Copyright (c) 2015 HumourStudio. All rights reserved.
//

#import "FEZTwitter.h"

@interface FEZTwitter ()

@property (nonatomic) HUKTwitter *twitter;

@end

@implementation FEZTwitter

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.twitter = [[HUKTwitter alloc] init];
    }
    return self;
}

- (RACSignal *)authorize
{
    return [self.twitter rac_authorize];
}

- (RACSignal *)ensureAuthorized
{
    if (self.twitter.authorized) {
        return [RACSignal empty];
    }
    return [self authorize];
}

- (RACSignal *)fetchHomeTimeline
{
    return [[[self ensureAuthorized]
            then:^{
                return [self.twitter rac_getStatusesHomeTimeline];
            }] map:^(NSArray *jsonArray) {
                return [FEZTimeline timelineFromTweetJsonArray:jsonArray];
            }];
}

@end