//
//  UserStore.h
//  Fashion
//
//  Created by Lakhwinder Singh on 10/12/15.
//  Copyright © 2015 lakh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface UserStore : NSObject
//! Singleton (shared instance)
+ (instancetype)shared;

- (BOOL)isLoggedIn;

- (void)loginWithUserName:(NSString *)userName andPassword:(NSString *)password withCompletion:(void(^)(NSError *error, User *user))completion;

- (void)getPasswordWithUserName:(NSString *)userName withCompletion:(void(^)(NSError *error, NSString *msg))completion;

@end

#define FASHION_API_BASE_URL @"http://fashion.ie/api"


//http://fashion.ie/api/user/register/?username=john&email=john@domain.com&nonce=bc6d5a50ac&display_name=John&seconds=100