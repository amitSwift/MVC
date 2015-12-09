//
//  UserStore.m
//  Fashion
//
//  Created by Lakhwinder Singh on 10/12/15.
//  Copyright © 2015 lakh. All rights reserved.
//

#import "UserStore.h"

@implementation UserStore

#pragma mark Singleton

+ (instancetype)shared {
    static dispatch_once_t predicate;
    static UserStore *shared;
    dispatch_once(&predicate, ^{
        shared = [[super allocWithZone:nil] init];
    }); return shared;
}

- (BOOL)isLoggedIn {
    return NO;
}

@end


