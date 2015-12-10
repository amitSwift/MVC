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

//////////////////////////////////////////////////////////////////////////////////////////////////

@implementation Author

+ (instancetype)authorFromJSON:(id)json {
    Author *author = [Author new];
    author.authorId = json[@"id"];
    author.slug = json[@"slug"];
    author.name = json[@"name"];
    author.firstName = json[@"first_name"];
    author.lastName = json[@"last_name"];
    author.nickname = json[@"nickname"];
    author.url = json[@"url"];
    author.authorDescription = json[@"description"];
    return author;
}

@end


