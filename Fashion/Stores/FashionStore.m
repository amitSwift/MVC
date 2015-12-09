//
//  FashionStore.m
//  Fashion
//
//  Created by Lakhwinder Singh on 03/12/15.
//  Copyright © 2015 lakh. All rights reserved.
//

#import "FashionStore.h"
#import "NSURLSession.h"
#import "News.h"

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
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://fashion.ie/api/get_posts?page=%lu",page]]; // Construct URL
    [NSURLSession jsonFromURL:url completion:^(id json){
        NSArray *news = [self isListJsonOK:json] ? [self newsArrayWithJSON:json[KEY_RESULTS]] : nil; // Get the result
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

//! Check if we got correct list result from api
- (BOOL)isListJsonOK:(id)json {
    return json && json[@"status"] && [json[KEY_RESULTS] count] > 0;
}

@end


