//
//  News.h
//  Fashion
//
//  Created by Lakhwinder Singh on 03/12/15.
//  Copyright © 2015 lakh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Author.h"

/*
 News get from API http://fashion.ie/api/get_posts
 */

@interface News : NSObject

+ (instancetype)newsFromJSON:(id)json;

@property (strong, nonatomic) NSNumber *newsId;

@property (strong, nonatomic) NSString *title;

@property (strong, nonatomic) NSString *newsDescription;

@property (strong, nonatomic) NSString *newsURL;

@property (strong, nonatomic) NSString *contentWeb;

@property (strong, nonatomic) NSString *imageUrl;

@property (strong, nonatomic) NSDate *dateGet;

@property (strong, nonatomic) NSString *date;

@property (strong, nonatomic) Author *author;

@end


