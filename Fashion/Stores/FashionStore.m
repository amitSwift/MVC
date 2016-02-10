//
//  FashionStore.m
//  Fashion
//
//  Created by Rana on 03/12/15.
//  Copyright © 2015 lakh. All rights reserved.
//

#import "FashionStore.h"
#import "News.h"
#import "Comment.h"
#import "LibOften.h"
#import "Product.h"

#define KEY_RESULTS @"posts"

@implementation FashionStore

#pragma mark Singleton

+ (instancetype)shared {
    static dispatch_once_t predicate;
    static FashionStore *shared;
    dispatch_once(&predicate, ^{
        shared = [[super allocWithZone:nil] init];
    }); return shared;
}

#pragma mark news requests

- (void)requestNews:(NSInteger)page withCompletion:(void(^)(NSArray *news, NSError *error))completion {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/get_posts?page=%lu",FASHION_JSON_BASE_URL,(long)page]]; // Construct URL
    [NSURLSession jsonFromURL:url completion:^(id json){
        NSArray *news = [self isListJsonOK:json] ? [self newsArrayWithJSON:json[KEY_RESULTS]] : nil; // Get the result
        dispatch_async_main(^{
            completion(news, nil);
        }); // Execute completion block
    }];
}

- (void)requestCommentsForNews:(News *)news withCompletion:(void(^)(NSArray *comments, NSError *error))completion {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://fashion.ie/?json=get_post&post_id=%@",news.newsId]]; // Construct URL
    [NSURLSession jsonFromURL:url completion:^(id json){
        NSArray *news = [self isListJsonOK:json] ? [self commentsArrayWithJSON:json[@"post"][@"comments"]] : nil; // Get the result
        dispatch_async_main(^{
            completion(news, nil);
        }); // Execute completion block
    }];
}

//! Returns array of news from JSON
- (NSArray *)newsArrayWithJSON:(id)json {
    NSMutableArray *newsArray = [NSMutableArray new];
    for (NSDictionary *item in json) {
        News *news = [News newsFromJSON:item];
        if (news) [newsArray addObject:news];
    }
    return newsArray.count > 0 ? newsArray : nil;
}

//! Returns array of news from JSON
- (NSArray *)commentsArrayWithJSON:(id)json {
    NSMutableArray *commentsArray = [NSMutableArray new];
    for (NSDictionary *item in json) {
        Comment *comment = [Comment commentFromJSON:item];
        if (comment) [commentsArray addObject:comment];
    }
    return commentsArray.count > 0 ? commentsArray : nil;
}

//! Check if we got correct list result from api
- (BOOL)isListJsonOK:(id)json {
    return json && [json[@"status"] isEqualToString:@"ok"];
}

@end


