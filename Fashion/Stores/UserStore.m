//
//  UserStore.m
//  Fashion
//
//  Created by Lakhwinder Singh on 10/12/15.
//  Copyright © 2015 lakh. All rights reserved.
//

#import "UserStore.h"
#import "LibOften.h"

#define NONCE_METHOD_LOGIN @"generate_auth_cookie"
#define NONCE_METHOD_REGISTER @"register"

#define USERDEFAULT_USER_CHECK @"isLoggedIn"
#define USERDEFAULT_USER_DATA @"UserData"

@interface UserStore ()

@end

@implementation UserStore

#pragma mark Singleton

+ (instancetype)shared {
    static dispatch_once_t predicate;
    static UserStore *shared;
    dispatch_once(&predicate, ^{
        shared = [[super allocWithZone:nil] init];
    }); return shared;
}

- (void)getNonceWithMethod:(NSString *)method withCompletion:(void(^)(NSString *nonce))completion {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/get_nonce/?controller=user&method=%@",FASHION_API_BASE_URL, method]];
    [NSURLSession jsonFromURL:url completion:^(id json){
        completion (json[@"nonce"]);
    }];
}

- (void)loginWithUserName:(NSString *)userName andPassword:(NSString *)password withCompletion:(void(^)(NSError *error, User *user))completion {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/user/generate_auth_cookie/?username=%@&password=%@",FASHION_API_BASE_URL, userName, password]];
    [NSURLSession jsonFromURL:url completion:^(id json){
        if ([json[@"status"] isEqualToString:@"error"]) {
            NSError *error = [NSError errorWithFormat:json[@"error"]];
            dispatch_async_main_safely_variadic (completion, error, nil);
        }
        else if (!json) {
            dispatch_async_main_safely_variadic (completion, nil, nil);
        }
        else {
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:USERDEFAULT_USER_CHECK];
            [[NSUserDefaults standardUserDefaults] setObject:json forKey:USERDEFAULT_USER_DATA];
            dispatch_async_main_safely_variadic (completion, nil, [User userFromJSON:json]);
        }
    }];
}

- (void)getPasswordWithUserName:(NSString *)userName withCompletion:(void(^)(NSError *error, NSString *msg))completion {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/user/retrieve_password/?user_login=%@",FASHION_API_BASE_URL, userName]];
    [NSURLSession jsonFromURL:url completion:^(id json){
        if ([json[@"status"] isEqualToString:@"error"]) {
            NSError *error = [NSError errorWithFormat:json[@"error"]];
            dispatch_async_main_safely_variadic (completion, error, nil);
        }
        else {
            dispatch_async_main_safely_variadic (completion, nil, json[@"msg"]);
        }
    }];
}

- (void)registerWithDisplayName:(NSString *)displayName userName:(NSString *)userName email:(NSString *)email password:(NSString *)password withCompletion:(void(^)(NSError *error, User *user))completion {
    [self getNonceWithMethod:NONCE_METHOD_REGISTER withCompletion:^(NSString *nonce) {
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/user/register/?username=%@&email=%@&nonce=%@&display_name=%@&user_pass=%@&seconds=100",FASHION_API_BASE_URL, userName, email, nonce, displayName, password]];
        [NSURLSession jsonFromURL:url completion:^(id json){
            if ([json[@"status"] isEqualToString:@"error"]) {
                NSError *error = [NSError errorWithFormat:json[@"error"]];
                dispatch_async_main_safely_variadic (completion, error, nil);
            }
            else {
                if (json && [json[@"cookie"] length]) {
                    [self loginWithUserName:userName andPassword:password withCompletion:completion];
                }
                else {
                    dispatch_async_main_safely_variadic (completion, nil, nil);
                }
            }
        }];
    }];
}

- (User *)getUser {
    if ([self isLoggedIn]) {
        NSDictionary *json = [[NSUserDefaults standardUserDefaults] objectForKey:USERDEFAULT_USER_DATA];
        return [User userFromJSON:json];
    }
    else {
        return nil;
    }
}

- (void)logoutUser {
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:USERDEFAULT_USER_DATA];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:USERDEFAULT_USER_CHECK];
}

- (BOOL)isLoggedIn {
    return [[NSUserDefaults standardUserDefaults] boolForKey:USERDEFAULT_USER_CHECK];
}

@end


