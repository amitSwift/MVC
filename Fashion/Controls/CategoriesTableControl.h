//
//  categoriesTableControl.h
//  Fashion
//
//  Created by Lakhwinder Singh on 10/12/15.
//  Copyright © 2015 lakh. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CategoriesTableDelegate <NSObject>

- (void)selectCategory;

@end

@interface CategoriesTableControl : UITableViewController <UITableViewDataSource, UITableViewDelegate>

+ (instancetype)controlWithDelegate:(id <CategoriesTableDelegate>)delegateTable;

@end


