//
//  UserStore.h
//  Fashion
//
//  Created by Lakhwinder Singh on 10/12/15.
//  Copyright © 2015 lakh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserStore : NSObject
//! Singleton (shared instance)
+ (instancetype)shared;

- (BOOL)isLoggedIn;

@end


