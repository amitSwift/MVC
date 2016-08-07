//
//  Shipping.m
//  Fashion
//
//  Created by Lakhwinder Singh on 25/05/16.
//  Copyright © 2016 lakh. All rights reserved.
//

#import "Shipping.h"

@implementation Shipping

+ (instancetype)shippingFromJSON:(id)json {
    Shipping *ship = [Shipping new];
    ship.shippingId = [json[@"id"] integerValue];
    ship.name = json[@"name"];
    ship.slug = json[@"slug"];
    ship.count = [json[@"count"] integerValue];
    return ship;
}

@end


