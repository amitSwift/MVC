//
//  categoriesTableControl.m
//  Fashion
//
//  Created by Rana on 10/12/15.
//  Copyright © 2015 lakh. All rights reserved.
//

#import "CategoriesTableControl.h"
#import "LibOften.h"
#import "ProductStore.h"

@interface CategoriesTableControl () {
    NSArray *items;
}
@property (weak, nonatomic) id <CategoriesTableDelegate> delegateTable;

@property (strong, nonatomic, readonly) UILabel *noDataFoundLabel;
/// Pull-to-refresh control
@property (strong, nonatomic, readonly) UIRefreshControl *refreshControl;
@end

@implementation CategoriesTableControl
@synthesize refreshControl = _refreshControl, noDataFoundLabel = _noDataFoundLabel;

+ (instancetype)controlWithDelegate:(id<CategoriesTableDelegate>)delegateTable {
    CategoriesTableControl *control = [[UIStoryboard mainStoryboard] instantiateViewControllerWithIdentifier:@"CategoriesTableControl"];
    control.delegateTable = delegateTable;
    return control;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [UIView new];
    [self.tableView addSubviews:@[self.noDataFoundLabel, self.refreshControl]];
    self.noDataFoundLabel.hidden = YES;
    [SVProgressHUD show];
    [self reload];
}

- (UILabel *)noDataFoundLabel {
    if (!_noDataFoundLabel) {
        _noDataFoundLabel = [UILabel new];
        _noDataFoundLabel.frame = self.tableView.frame;
        _noDataFoundLabel.text = @"No category found!\nPull down to refresh.";
        _noDataFoundLabel.textColor = COLOR_FASHION_PINK;
        _noDataFoundLabel.font = [UIFont boldSystemFontOfSize:20.0f];
        _noDataFoundLabel.numberOfLines = 0;
        _noDataFoundLabel.textAlignment = NSTextAlignmentCenter;
    } return _noDataFoundLabel;
}

- (UIRefreshControl *)refreshControl {
    if (!_refreshControl) {
        _refreshControl = [UIRefreshControl new];
        [_refreshControl addTarget:self action:@selector(reload) forControlEvents:UIControlEventValueChanged];
    } return _refreshControl;
}

- (void)reload {
    [[ProductStore shared] requestProductsCategoriesWithCompletion:^(NSArray *categories, NSError *error) {
        if (categories.count == 0) {
            [SVProgressHUD showErrorWithStatus:@"No category found."];
        }
        else {
            [SVProgressHUD dismiss];
        }
        items = categories;
        [self.tableView reloadData];
        self.noDataFoundLabel.hidden = items.count;
        [self.refreshControl endRefreshing];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    CategoryPro *category = items[indexPath.row];
    cell.textLabel.text = category.title;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.delegateTable selectCategory:items[indexPath.row]];
}

@end


