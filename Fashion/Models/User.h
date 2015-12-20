//
//  User.h
//  Fashion
//
//  Created by Lakhwinder Singh on 19/12/15.
//  Copyright © 2015 lakh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

+ (instancetype)userFromJSON:(id)json;

@property (strong, nonatomic) NSString *userId;

@property (strong, nonatomic) NSString *userName;

@property (strong, nonatomic) NSString *nickName;

@property (strong, nonatomic) NSString *email;

@property (strong, nonatomic) NSString *url;

@property (strong, nonatomic) NSDate *registerDate;

@property (strong, nonatomic) NSString *displayName;

@property (strong, nonatomic) NSString *firstName;

@property (strong, nonatomic) NSString *lastName;

@property (strong, nonatomic) NSString *userDescription;

@property (strong, nonatomic) NSString *avatar;

@property (nonatomic) BOOL subscriber;

@property (strong, nonatomic) NSString *cookie;

@property (strong, nonatomic) NSString *cookieName;

@end


