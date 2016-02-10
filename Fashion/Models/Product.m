//
//  Product.m
//  Fashion
//
//  Created by Rana on 22/12/15.
//  Copyright © 2015 lakh. All rights reserved.
//

#import "Product.h"

@implementation Product

+ (instancetype)productFromJSON:(id)json {
    Product *product = [Product new];
    product.productId = json[@"id"];
    product.title = json[@"title"];
    product.slug = json[@"slug"];
    product.imageUrl = [NSURL URLWithString:json[@"thumbnail_images"][@"shop_catalog"][@"url"]];
    product.productDetails = json[@"content"];
    product.author = [Author authorFromJSON:json[@"author"]];
    product.sellerDetails = [product tempSellerDetails];
    
    product.price = json[@"custom_fields"][@"_price"][0];
    product.inStock = [json[@"custom_fields"][@"_stock"][0] integerValue];
    product.inStockAvailable = [json[@"custom_fields"][@"_stock_status"][0] isEqualToString:@"instock"] ? YES : NO;
    product.productCode = [NSString stringWithFormat:@"SKU: %@", json[@"custom_fields"][@"_sku"][0]];
    
    NSString *wieght = json[@"custom_fields"][@"_weight"][0];
    NSString *width = json[@"custom_fields"][@"_width"][0];
    NSString *height = json[@"custom_fields"][@"_height"][0];
    NSString *length = json[@"custom_fields"][@"_length"][0];
    NSString *dimenstions = [NSString stringWithFormat:@"%@ x %@ x %@ cm",length, width, height];
    if (wieght) product.additionalInformation = @{@"Weight" : wieght, @"Dimensions" : dimenstions};
    
    product.refundPolicy = json[@"author"][@"_dps_refund_policy"];
    product.shippingPolicy = json[@"author"][@"_dps_ship_policy"];
    
    //Static info's
    product.shipInfo = @"Ready to ship in 3-5 business day from Australia";

    return product;
}

- (NSString *)tempSellerDetails {
    return [NSString stringWithFormat:@"• Store Name: %@\n• Seller: %@\n• Address: 3/703 Esplanade, Mornington, Victoria, 3931, Australia\n• No ratings found yet!", self.author.nickname , self.author.name];
}

@end


