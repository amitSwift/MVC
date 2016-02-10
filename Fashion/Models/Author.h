//
//  Author.h
//  Fashion
//
//  Created by Rana on 27/12/15.
//  Copyright © 2015 lakh. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 Author get from API http://fashion.ie/
 */

@interface Author : NSObject
///Use keys used in api
+ (instancetype)authorFromJSON:(id)json;

@property (strong, nonatomic) NSNumber *authorId;

@property (strong, nonatomic) NSString *slug;

@property (strong, nonatomic) NSString *name;

@property (strong, nonatomic) NSString *firstName;

@property (strong, nonatomic) NSString *lastName;

@property (strong, nonatomic) NSString *nickname;

@property (strong, nonatomic) NSString *url;

@property (strong, nonatomic) NSString *authorDescription;

@end


