//
//  ProductStore.m
//  Fashion
//
//  Created by Lakhwinder Singh on 27/12/15.
//  Copyright © 2015 lakh. All rights reserved.
//

#import "ProductStore.h"
#import "LibOften.h"

#define KEY_RESULTS @"posts"

@implementation ProductStore

+ (instancetype)shared {
    static dispatch_once_t predicate;
    static ProductStore *shared;
    dispatch_once(&predicate, ^{
        shared = [[super allocWithZone:nil] init];
    }); return shared;
}
- (void)requestProductsCategoriesWithCompletion:(void(^)(NSArray *categories, NSError *error))completion {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/term/product_cat.json",FASHION_API_BASE_URL]]; // Construct URL
    [NSURLSession jsonFromURL:url completion:^(id json){
        NSArray *categories = [self isProductsJsonOK:json] ? [self categoriesArrayWithJSON:json[@"data"]] : nil; // Get the result
        dispatch_async_main(^{
            completion(categories, nil);
        }); // Execute completion block
    }];
}

- (void)requestProductsForCategory:(CategoryPro *)category page:(NSInteger)page withCompletion:(void(^)(NSArray *products, NSError *error, BOOL isMoreProducts))completion {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://fashion.ie/product-category/%@/?json=get_posts&page=%lu",category.slug,(long)page]]; // Construct URL
    [NSURLSession jsonFromURL:url completion:^(id json){
        NSArray *products = [self isListJsonOK:json] ? [self productsArrayWithJSON:json[KEY_RESULTS]] : nil; // Get the result
        dispatch_async_main(^{
            completion(products, nil, page != [json[@"pages"] integerValue]);
        }); // Execute completion block
    }];
}

//! Returns array of categories from JSON
- (NSArray *)categoriesArrayWithJSON:(NSDictionary *)json {
    NSMutableArray *proCatArray = [NSMutableArray new];
    for (NSDictionary *key in json.allKeys) {
        CategoryPro *proCat = [CategoryPro categoryFromJSON:json[key]];
        if (proCat) [proCatArray addObject:proCat];
    }
    return proCatArray.count > 0 ? proCatArray : nil;
}

//! Returns array of products from JSON
- (NSArray *)productsArrayWithJSON:(id)json {
    NSMutableArray *productsArray = [NSMutableArray new];
    for (NSDictionary *item in json) {
        Product *product = [Product productFromJSON:item];
        if (product) [productsArray addObject:product];
    }
    return productsArray.count > 0 ? productsArray : nil;
}

//! Check if we got correct list result from api
- (BOOL)isProductsJsonOK:(id)json {
    return json && [json[@"message"] isEqualToString:@"200 OK"];
}

//! Check if we got correct list result from api
- (BOOL)isListJsonOK:(id)json {
    return json && json[@"status"] && [json[KEY_RESULTS] count] > 0;
}

@end


