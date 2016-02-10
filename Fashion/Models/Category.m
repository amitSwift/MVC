//
//  ProductCategories.m
//  Fashion
//
//  Created by Rana on 27/12/15.
//  Copyright © 2015 lakh. All rights reserved.
//

#import "Category.h"
#import "LibOften.h"

@implementation CategoryPro

+ (instancetype)categoryFromJSON:(id)json {
    CategoryPro *cat = [CategoryPro new];
    cat.title = json[@"name"];
    cat.slug = json[@"slug"];
    cat.categoryDescription = json[@"description"];
    cat.catId = json[@"term_id"];
    return cat;
}

@end


