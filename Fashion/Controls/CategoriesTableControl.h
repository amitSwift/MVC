//
//  categoriesTableControl.h
//  Fashion
//
//  Created by Rana on 10/12/15.
//  Copyright © 2015 lakh. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CategoryPro;

@protocol CategoriesTableDelegate <NSObject>

- (void)selectCategory:(CategoryPro *)category;

@end

@interface CategoriesTableControl : UITableViewController <UITableViewDataSource, UITableViewDelegate>

+ (instancetype)controlWithDelegate:(id <CategoriesTableDelegate>)delegateTable;

@end


