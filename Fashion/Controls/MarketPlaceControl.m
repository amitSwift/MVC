//
//  MarketPlaceControl.m
//  Fashion
//
//  Created by Lakhwinder Singh on 06/12/15.
//  Copyright © 2015 lakh. All rights reserved.
//

#import "MarketPlaceControl.h"
#import "CategoriesTableControl.h"
#import "LibOften.h"
#import "FashionStore.h"
#import "ProductCell.h"
#import "ProductDetail.h"

@interface MarketPlaceControl ()<CategoriesTableDelegate, UICollectionViewDataSource, UICollectionViewDelegate> {
    BOOL isMenuShow;
    NSMutableArray *items;
}
@property (strong, nonatomic, readonly) CategoriesTableControl *categoriesTableControl;
@property (strong, nonatomic) IBOutlet UIView *viewBack;
@property (strong, nonatomic) IBOutlet UILabel *lblNoProductsFound;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

- (IBAction)menuButton:(id)sender;

@end

@implementation MarketPlaceControl
@synthesize categoriesTableControl = _categoriesTableControl;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initViews];
    // Do any additional setup after loading the view.
}

- (void)initViews {
    isMenuShow = YES;
    [self.viewBack addSubview:self.categoriesTableControl.view];
    [self.view bringSubviewToFront:self.viewBack];
    self.lblNoProductsFound.text = @"No prodcuts found!\nTap anywhere to refresh.";
    
    [self.collectionView setCollectionViewLayout:self.customLayout animated:YES];
    
    DefineWeakSelf;
    self.lblNoProductsFound.actionBlock = ^{
        [weakSelf reload];
    };
}

- (void)reload {
    [SVProgressHUD show];
    self.lblNoProductsFound.hidden = YES;
    [self loadProducts];
}

- (void)loadProducts {
    [[FashionStore shared] requestProducts:1 categoryId:1 withCompletion:^(NSArray *products, NSError *error) {
        if (products.count == 0) {
            [SVProgressHUD showErrorWithStatus:@"No news found."];
        }
        else {
            [SVProgressHUD dismiss];
        }
        items = [NSMutableArray new];
        [items addObjectsFromArray:products];
        [items addObjectsFromArray:products];
        [items addObjectsFromArray:products];
        [items addObjectsFromArray:products];
        [items addObjectsFromArray:products];
        [self reloadData];
    }];
}

- (void)reloadData {
    self.lblNoProductsFound.hidden = items.count;
    [self.collectionView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CategoriesTableControl *)categoriesTableControl {
    if (!_categoriesTableControl) {
        _categoriesTableControl = [CategoriesTableControl controlWithDelegate:self];
    } return _categoriesTableControl;
}

- (IBAction)menuButton:(id)sender {
    [self showHideCategories];
    [self.view bringSubviewToFront:self.viewBack];
}

- (void)selectCategory {
    [self showHideCategories];
}

- (void)showHideCategories {
    if (!isMenuShow) {
        isMenuShow = YES;
    } else {
        isMenuShow = NO;
    }
    CGRect frame = self.categoriesTableControl.view.frame;
    frame.origin.x = isMenuShow ? frame.size.width : 0;
    self.categoriesTableControl.view.frame = frame;
    [UIView animateWithDuration:0.2f animations:^{
        CGRect frame = self.categoriesTableControl.view.frame;
        frame.origin.x = isMenuShow ? 0 : frame.size.width;
        self.categoriesTableControl.view.frame = frame;
    } completion:^(BOOL finished) {
        if (!isMenuShow) {
            [self showProductList];
        }
    }];
}

- (void)showProductList {
    if (!items.count) {
        [self reload];
    }
    [self.view sendSubviewToBack:self.viewBack];
}

- (void)updateViewConstraints {
    NSDictionary *views = @{@"categoriesTable":self.categoriesTableControl.view};
    [self.viewBack addVisualConstraints:@[@"H:|[categoriesTable]|", @"V:|[categoriesTable]|"] forSubviews:views];
    [super updateViewConstraints];
}
#pragma mark - Collection view delegates and some methods for collection view

- (UICollectionViewFlowLayout *)customLayout { // FIXME: should convert to +[AbstractListControl collectionViewLayout]
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.itemSize = [self cellSize];
    layout.minimumLineSpacing = 5;
    layout.minimumInteritemSpacing = 5;
    return layout;
}

- (CGSize)cellSize {
    CGFloat width = (self.view.bounds.size.width/2)-10;
    return CGSizeMake(width, width *1.33);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [items count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ProductCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ResueID" forIndexPath:indexPath];
    [cell updateWithModel:items[indexPath.row]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    ProductDetail *detail = [ProductDetail controlWithProduct:items[indexPath.row]];
    [self.navigationController pushViewController:detail animated:YES];
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    BOOL lastItemReached = indexPath.item == items.count - 1;
    if (lastItemReached)
        dispatch_async_main(^{ // Avoid race condition
//            [self requestItemsForNextPage];
        });
}

@end


