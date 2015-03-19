//
//  FEZTweet.m
//  Fezaar
//
//  Created by t-matsumura on 3/20/15.
//  Copyright (c) 2015 HumourStudio. All rights reserved.
//

#import "FEZTweet.h"

@implementation FEZTweet

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
        @"statusID" : @"id_str"
    };
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"FEZTweet statusID:%@, text:%@", self.statusID, self.text];
}

@end
