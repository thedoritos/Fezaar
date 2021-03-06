//
//  HUKTwitter.h
//  Fezaar
//
//  Created by t-matsumura on 3/21/15.
//  Copyright (c) 2015 HumourStudio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Accounts/Accounts.h>
#import <Social/Social.h>

#import "HUKTwitterError.h"

typedef void(^ErrorHandler)(NSError *error);
typedef void(^AccountHandler)(ACAccount *account);
typedef void(^JsonObjectHandler)(id jsonObject);
typedef void(^JsonArrayHandler)(NSArray *jsonArray);
typedef void(^JsonDictionaryHandler)(NSDictionary *jsonDictionary);

@interface HUKTwitter : NSObject

- (BOOL)authorized;

- (void)authorizeSuccess:(AccountHandler)accountHandler failure:(ErrorHandler)errorHandler;

- (void)getStatusesHomeTimelineSuccess:(JsonArrayHandler)jsonArrayHandler failure:(ErrorHandler)errorHandler;

- (void)getStatusesHomeTimelineWithSinceID:(NSNumber *)sinceID
                                     maxID:(NSNumber *)maxID
                                   success:(JsonArrayHandler)jsonArrayHandler
                                   failure:(ErrorHandler)errorHandler;

- (void)getListsOwnerships:(JsonDictionaryHandler)jsonDictionaryHandler failure:(ErrorHandler)errorHandler;

- (void)getListsStatuses:(NSNumber *)listID
                 success:(JsonArrayHandler)jsonArrayHandler
                 failure:(ErrorHandler)errorHandler;

- (void)getListsStatuses:(NSNumber *)listID
                 sinceID:(NSNumber *)sinceID
                   maxID:(NSNumber *)maxID
                 success:(JsonArrayHandler)jsonArrayHandler
                 failure:(ErrorHandler)errorHandler;

@end
