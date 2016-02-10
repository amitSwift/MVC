//
//  UserStore.h
//  Fashion
//
//  Created by Rana on 10/12/15.
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

- (void)registerWithDisplayName:(NSString *)displayName userName:(NSString *)userName email:(NSString *)email password:(NSString *)password withCompletion:(void(^)(NSError *error, User *user))completion;
//! Asynchronously post comment for news
- (void)addComment:(NSString *)comment postId:(NSString *)postId withCompletion:(void(^)(BOOL success, NSError *error))completion;

- (User *)getUser;

- (void)logoutUser;

@end


