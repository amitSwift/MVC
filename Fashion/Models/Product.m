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
    product.imageUrl = [NSURL URLWithString:json[@"featured_src"]];
    product.productDetails = json[@"description"];
//    product.author = [Author authorFromJSON:json[@"author"]];
    product.sellerDetails = [product tempSellerDetails];
    
    product.price = json[@"price"];
    product.inStock = [json[@"in_stock"] boolValue];
    product.inStockAvailable = [json[@"in_stock"] boolValue];
    product.productCode = [NSString stringWithFormat:@"SKU: %@", json[@"sku"]];
    
    NSString *wieght = json	[@"weight"];
    NSString *width = json[@"dimensions"][@"width"];
    NSString *height = json[@"dimensions"][@"height"];
    NSString *length = json[@"dimensions"][@"length"];
    NSString *dimenstions = [NSString stringWithFormat:@"%@ x %@ x %@ cm",length, width, height];
    if (wieght) product.additionalInformation = @{@"Weight" : wieght, @"Dimensions" : dimenstions};
    
//    product.refundPolicy = json[@"author"][@"_dps_refund_policy"];
//    product.shippingPolicy = json[@"author"][@"_dps_ship_policy"];

    product.refundPolicy = @"N/A";
    product.shippingPolicy = @"N/A";
    
    //Static info's
    product.shipInfo = json[@"shipping_class"];
    
    product.shippingClass = json[@"shipping_class"];
    product.shippingClassID = [json[@"shipping_class_id"] integerValue];
    product.shippingRequired = [json[@"shipping_required"] boolValue];
    product.shippingTaxable = [json[@"shipping_taxable"] boolValue];

    return product;
}

- (NSString *)tempSellerDetails {
    return [NSString stringWithFormat:@"Sold By Fashion.ie"];
}

@end


