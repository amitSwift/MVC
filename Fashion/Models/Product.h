//
//  Product.h
//  Fashion
//
//  Created by Lakhwinder Singh on 22/12/15.
//  Copyright © 2015 lakh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Author.h"

@interface Product : NSObject

+ (instancetype)productFromJSON:(id)json;

@property (strong, nonatomic) NSString *productId;

@property (strong, nonatomic) NSString *title;

@property (strong, nonatomic) NSString *slug;

@property (strong, nonatomic) NSString *price;

@property (strong, nonatomic) NSURL *imageUrl;

@property (nonatomic) NSInteger inStock;

@property (nonatomic) BOOL inStockAvailable;

@property (strong, nonatomic) NSString *productCode;

@property (strong, nonatomic) NSString *shipInfo;

@property (strong, nonatomic) NSString *shippingPolicy;

@property (strong, nonatomic) NSString *refundPolicy;

@property (strong, nonatomic) NSDictionary *additionalInformation;

@property (strong, nonatomic) NSString *productDetails;

@property (strong, nonatomic) NSString *sellerDetails;

@property (strong, nonatomic) Author *author;

//@property (strong, nonatomic) NSArray *productDetails;
//
//@property (strong, nonatomic) NSArray *sellerDetails;
@end


