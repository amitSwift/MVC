//
//  ProductStore.h
//  Fashion
//
//  Created by Rana on 27/12/15.
//  Copyright © 2015 lakh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Category.h"
#import "Product.h"
#import "Shipping.h"

@interface ProductStore : NSObject
//! Singleton (shared instance)
+ (instancetype)shared;
//! Asynchronously returns product categories array
- (void)requestProductsCategoriesWithCompletion:(void(^)(NSArray *categories, NSError *error))completion;
//! Asynchronously returns product categories array
- (void)requestProductsForCategory:(CategoryPro *)category page:(NSInteger)page withCompletion:(void(^)(NSArray *products, NSError *error))completion;
//! Asynchronously returns full product
- (void)requestProductsDetail:(Product *)category withCompletion:(void(^)(Product *product, NSError *error))completion;
//! Asynchronously returns shipping class
- (void)requestShippingDetail:(NSInteger)shippingClassId withCompletion:(void(^)(Shipping *ship))completion;
@end


