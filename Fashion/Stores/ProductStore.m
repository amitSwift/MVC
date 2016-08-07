//
//  ProductStore.m
//  Fashion
//
//  Created by Rana on 27/12/15.
//  Copyright © 2015 lakh. All rights reserved.
//

#import "ProductStore.h"
#import "LibOften.h"

#define CONSUMER_KEY @"ck_eb4fdd1fc2b1485c756f8e6d340c01192616ba02"
#define CONSUMER_SECRET @"cs_4d2ad83b759c4f98523d47deb2185dc9f0fa6bf5"
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
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/products/categories",FASHION_WC_JSON_BASE_URL]]; // Construct URL
    
    [NSURLSession jsonFromURLRequest:[self urlRequestWithURL:url] completion:^(id json){
        NSArray *categories = [self categoriesArrayWithJSON:json[@"product_categories"]]; // Get the result
        dispatch_async_main(^{
            completion(categories, nil);
        }); // Execute completion block
    }];
}

- (void)requestProductsForCategory:(CategoryPro *)category page:(NSInteger)page withCompletion:(void(^)(NSArray *products, NSError *error))completion {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/products?filter[category]=%@&page=%lu",FASHION_WC_JSON_BASE_URL, category.slug, page]]; // Construct URL
    
    [NSURLSession jsonFromURLRequest:[self urlRequestWithURL:url] completion:^(id json){
        NSArray *products = [self productsArrayWithJSON:json[@"products"]]; // Get the result
        dispatch_async_main(^{
            completion(products, nil);
        }); // Execute completion block
    }];
}

- (void)requestProductsDetail:(Product *)product withCompletion:(void(^)(Product *product, NSError *error))completion {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/products/%@",FASHION_WC_JSON_BASE_URL, product.productId]]; // Construct URL
    
    [NSURLSession jsonFromURLRequest:[self urlRequestWithURL:url] completion:^(id json){
        dispatch_async_main(^{
            completion([Product productFromJSON:json[@"product"]], nil);
        }); // Execute completion block
    }];
}

- (void)requestShippingDetail:(NSInteger)shippingClassId withCompletion:(void(^)(Shipping *ship))completion {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/products/shipping_classes/%lu", FASHION_WC_JSON_BASE_URL, shippingClassId]]; // Construct URL
    
    [NSURLSession jsonFromURLRequest:[self urlRequestWithURL:url] completion:^(id json){
        dispatch_async_main(^{
            completion([Shipping shippingFromJSON:json[@"product_shipping_class"]]);
        }); // Execute completion block
    }];
}

- (NSURLRequest *)urlRequestWithURL:(NSURL *)url {
    NSString *authStr = [NSString stringWithFormat:@"%@:%@", CONSUMER_KEY, CONSUMER_SECRET];
    NSString *authValue = [NSString stringWithFormat:@"Basic %@", [[authStr dataUsingEncoding:NSUTF8StringEncoding] base64EncodedStringWithOptions:0]];
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:url];
    [urlRequest setValue:authValue forHTTPHeaderField:@"Authorization"];
    return urlRequest;
}

//! Returns array of categories from JSON
- (NSArray *)categoriesArrayWithJSON:(id)json {
    NSMutableArray *proCatArray = [NSMutableArray new];
    for (NSDictionary *dict in json) {
        CategoryPro *proCat = [CategoryPro categoryFromJSON:dict];
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
    return json && [json[@"status"] isEqualToString:@"ok"];
}

@end


