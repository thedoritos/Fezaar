//
//  FEZTimeline.m
//  Fezaar
//
//  Created by t-matsumura on 3/20/15.
//  Copyright (c) 2015 HumourStudio. All rights reserved.
//

#import <Underscore.m/Underscore.h>
#import "FEZTimeline.h"

#define _ Underscore

@implementation FEZTimeline

- (instancetype)initWithTweets:(NSArray *)tweets
{
    self = [super init];
    if (self) {
        _tweets = tweets;
    }
    return self;
}

+ (instancetype)timelineFromTweetJsonArray:(NSArray *)tweetJsonArray
{
    NSError *error = nil;
    NSArray *tweets = [MTLJSONAdapter modelsOfClass:[FEZTweet class] fromJSONArray:tweetJsonArray error:&error];
    
    if (error) {
        NSLog(@"Error: failed to parse json array:%@ with error:%@", tweetJsonArray, error);
    }
    
    return [[[self class] alloc] initWithTweets:tweets];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"FEZTimeline tweets:%@", self.tweets];
}

@end