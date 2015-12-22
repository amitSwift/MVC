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
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://fashion.ie/api/get_posts?page=%lu",(long)page]]; // Construct URL
    [NSURLSession jsonFromURL:url completion:^(id json){
        NSArray *news = [self isListJsonOK:json] ? [self newsArrayWithJSON:json[KEY_RESULTS]] : nil; // Get the result
        dispatch_async_main(^{
            completion(news, nil);
        }); // Execute completion block
    }];
}

- (void)requestProducts:(NSInteger)page categoryId:(NSInteger)catId withCompletion:(void(^)(NSArray *news, NSError *error))completion {
    completion([self productsArrayWithJSON:nil], nil);
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
- (NSArray *)productsArrayWithJSON:(id)json {
    NSMutableArray *productsArray = [NSMutableArray new];
    [productsArray addObject:[self dummyProduct]];
    return productsArray.count > 0 ? productsArray : nil;
}

- (Product *)dummyProduct {
    Product *product = [Product new];
    product.productId = @"test";
    product.title = @"LOF SUPERSIZE PRINT HOOD";
    product.price = @"58.00";
    product.imageUrl = [NSURL URLWithString:@"http://fashion.ie/wp-content/uploads/2015/10/LOFIMAGEOP3bw.jpg"];
    product.inStock = 100;
    product.productCode = @"SKU: LOFW1567";
    product.shipInfo = @"Ready to ship in 3-5 business day from Australia";
    product.shippingPolicy = @"Items will be dispatched within 3-5 business days. Then it usually takes 10 business days to customer internationally.";
    product.additionalInformation = @{@"Weight" : @"500GRAM kg",
                                      @"Dimensions" : @"34 x 25 x 5 cm"};
    
    product.productDetails = @"LOF SUPERSIZE PRINT HOOD\n• 350 GSM 80% Cotton, 20% Poly\n• Shoestring cord\n• Kangaroo pocket\n• Cotton lined hood\n• Anti-pill fabric\nXSML-3XL";
    product.sellerDetails = @"• Store Name: ladsoffortune\n• Seller: JULIAN DOYLE\n• Address: 3/703 Esplanade, Mornington, Victoria, 3931, Australia\n• No ratings found yet!";
//    product.productDetails = @[@"LOF SUPERSIZE PRINT HOOD",
//                               @"• 350 GSM 80% Cotton, 20% Poly",
//                               @"• Shoestring cord",
//                               @"• Kangaroo pocket",
//                               @"• Cotton lined hood",
//                               @"• Anti-pill fabric",
//                               @"XSML-3XL"];
//    product.sellerDetails = @[@"• Store Name: ladsoffortune",
//                              @"• Seller: JULIAN DOYLE",
//                              @"• Address: 3/703 Esplanade, Mornington, Victoria, 3931, Australia",
//                              @"• No ratings found yet!"];
    product.refundPolicy = @"RETURN POLICY\n\nIf the goods are faulty\n\nOur goods may come with guarantees that cannot be excluded under the Australian Consumer Law. You may be entitled to a replacements or refund for a major failure and compensation for any other reasonably foreseeable loss or damage. You also may be entitled to have the goods repaired or replaced if the goods fail to be of acceptable quality.\n\nIf you think that there is a fault with an item you have received, please let us know straight away by contacting our customer care team. Please include as many details as possible about the order and the problem with the goods.\n\nIf you change your mind. In addition to your rights in relation to faulty goods, you have 10 days to return your goods to Lads of Fortune from the date you receive your order and 40 days on International online orders. Please note that in the interests of hygiene, some goods cannot be returned, unless they have remained in their original wrapping or are faulty. If you change your mind about the goods (including the size or colour), the goods returned must be in their original condition, which includes any packaging. For example, shirts are to be returned along with the original polybag. All goods will be inspected on Return.\n\nReturns/ This section applies to the return of all goods, regardless of whether they are faulty or you change your mind or need a different size. You are responsible for the costs of returning goods to us. Any goods returned are your responsibility until they reach our office. Please ensure you package your return to prevent any damage to the items. We are not responsible for any items that are returned to us in error. Simply fill in the required details on your order receipt form, securely pack the merchandise and invoice in an appropriate shipping package.\n\nPlease send your returned goods to:\n\nLads of Fortune Online Returns 3/703 Espanade Mornington, Melbourne, Victoria, Australia, 3931. Returns can be processed by sending the goods back to the Online Store. Include your receipt and details of the payment type you used when you ordered. We try hard to accept all returns, in the unlikely event that an item is returned to us in an unsuitable condition, we may have to send it back to you. We recommend you use a postal service that insures you for the value of the goods you are returning.\n\nPLEASE NOTE:\n\na) Lads of Fortune will not be held responsible if there is a delay in delivery.\n\nb) Customers will be responsible for the return shipping and handling charge.\n\nc) For faulty or damaged goods, please contact us through contact tab at www.ladsoffortune.com If the product is deemed faulty after review we will then credit the cost of postage back to you.\n\nd) You need to send the order no to us-this will be made available when your complaint is sent through the contact tab.\n\ne) In the event that your product is lost in transit, Lads of Fortune will not be held liable and therefore recommends that you send all returns via Registered Post.\nf) We ask that you allow 7 business days from the day you return your package for your account to be credited.\nLads of Fortune reserves the right to determine whether a product is faulty and conduct a production and quality check. If deemed faulty by a Lads of Fortune Representative, a replacement item will be shipped where possible subject to stock availability or a credit note issued. A response for Faulty Claims will be received within 48 hours of the garments arrival at the Lads of Fortune Head Office.\n\nRETURN OF GIFT WITH PURCHASE OR PROMOTIONAL ITEMS\n\nShould you qualify for a Gift with Purchase upon meeting minimum spend requirements. Then however, choose to return your purchased goods for a full refund or credit note the Gift with Purchase must be returned also. This must be returned in its original saleable condition, with all tickets attached. If upon receiving your returned package the Free Gift is not enclosed, the retail value of the Gift with Purchase will be deducted from the refundable amount. A Lads of Fortune team member will contact you immediately and will await 10 business days before processing your payment. The cost of returning the Free Gift will be incurred by the purchaser.";
    return product;
}


//! Check if we got correct list result from api
- (BOOL)isListJsonOK:(id)json {
    return json && json[@"status"] && [json[KEY_RESULTS] count] > 0;
}

@end


