//
//  ProductDetail.h
//  Fashion
//
//  Created by Rana on 22/12/15.
//  Copyright © 2015 lakh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PayPalMobile.h"

#define kPayPalEnvironment PayPalEnvironmentNoNetwork

@class Product;

@interface ProductDetail : UIViewController <PayPalPaymentDelegate>
+ (instancetype)controlWithProduct:(Product *)product;

@property(nonatomic, strong, readwrite) NSString *environment;
@property(nonatomic, assign, readwrite) BOOL acceptCreditCards;
@property(nonatomic, strong, readwrite) NSString *resultText;

@end


