//
//  News.h
//  Fashion
//
//  Created by Lakhwinder Singh on 03/12/15.
//  Copyright © 2015 lakh. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Author;

/*
 News get from API http://fashion.ie/api/get_posts
 */

@interface News : NSObject

+ (instancetype)newsFromJSON:(id)json;

@property (strong, nonatomic) NSString *title;

@property (strong, nonatomic) NSString *newsDescription;

@property (strong, nonatomic) NSString *newsURL;

@property (strong, nonatomic) NSString *contentWeb;

@property (strong, nonatomic) NSString *imageUrl;

@property (strong, nonatomic) NSDate *dateGet;

@property (strong, nonatomic) NSString *date;

@property (strong, nonatomic) Author *author;

@end

//////////////////////////////////////////////////////////////////////////////////////////////////

/*
 Author get from API http://fashion.ie/api/get_posts
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



