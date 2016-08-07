//
//  ProductCategories.h
//  Fashion
//
//  Created by Rana on 27/12/15.
//  Copyright © 2015 lakh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CategoryPro : NSObject

+ (instancetype)categoryFromJSON:(id)json;

@property (strong, nonatomic) NSString *title;

@property (strong, nonatomic) NSString *slug;

@property (strong, nonatomic) NSString *categoryDescription;

@property (nonatomic) NSInteger productCount;

@property (nonatomic) NSInteger catId;

@end


