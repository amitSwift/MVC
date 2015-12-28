//
//  News.m
//  Fashion
//
//  Created by Lakhwinder Singh on 03/12/15.
//  Copyright © 2015 lakh. All rights reserved.
//

#import "News.h"
#import "LibOften.h"

@implementation News

+ (instancetype)newsFromJSON:(id)json {
    News *news = [News new];
    news.newsId = [NSNumber numberWithInteger:[json[@"id"] integerValue]];
    news.title = json[@"title"];
    news.newsDescription = json[@"excerpt"];
    news.newsURL = json[@"url"];
    news.contentWeb = json[@"content"];
    news.imageUrl = json[@"thumbnail"];
    news.dateGet = [NSDate dateFromString:json[@"date"] withFormat:@"yyyy-MM-dd HH:mm:ss"];
    news.author = [Author authorFromJSON:json[@"author"]];
    return news;
}

- (NSString *)date {
    return [self.dateGet stringWithFormat:@"MMMM dd, yyyy"];
}

@end


