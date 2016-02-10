//
//  User.m
//  Fashion
//
//  Created by Rana on 19/12/15.
//  Copyright © 2015 lakh. All rights reserved.
//

#import "User.h"
#import "LibOften.h"

@implementation User

+ (instancetype)userFromJSON:(id)json {
    User *user = [User new];
    user.userId = json[@"user"][@"id"];
    user.userName = json[@"user"][@"username"];
    user.nickName = json[@"user"][@"nickname"];
    user.email = json[@"user"][@"email"];
    user.displayName = json[@"user"][@"displayname"];
    user.firstName = json[@"user"][@"firstname"];
    user.lastName = json[@"user"][@"lastname"];
    user.userDescription = json[@"user"][@"description"];
    user.subscriber = [json[@"user"][@"capabilities"][@"subscriber"] boolValue];
    user.registerDate = [NSDate dateFromString:json[@"user"][@"registered"] withFormat:@"yyyy-MM-dd HH:mm:ss"];
    user.cookie = json[@"cookie"];
    user.cookieName = json[@"cookie_name"];
    return user;
}

@end


