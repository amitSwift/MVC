//
//  Shipping.h
//  Fashion
//
//  Created by Lakhwinder Singh on 25/05/16.
//  Copyright © 2016 lakh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Shipping : NSObject

+ (instancetype)shippingFromJSON:(id)json;

@property (nonatomic) NSInteger shippingId;

@property (strong, nonatomic) NSString *name;

@property (strong, nonatomic) NSString *slug;

@property (nonatomic) NSInteger count;

@end


