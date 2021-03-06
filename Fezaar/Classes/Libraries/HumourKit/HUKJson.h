//
//  HUKJson.h
//  Fezaar
//
//  Created by t-matsumura on 3/20/15.
//  Copyright (c) 2015 HumourStudio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HUKJson : NSObject

@end

@interface NSDictionary (HUKJson)

- (NSString*)huk_jsonStringWithPrettyPrint:(BOOL) prettyPrint;

@end

@interface NSArray (HUKJson)

- (NSString*)huk_jsonStringWithPrettyPrint:(BOOL) prettyPrint;

@end
