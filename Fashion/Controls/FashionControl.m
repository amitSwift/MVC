//
//  ViewController.m
//  Fashion
//
//  Created by Lakhwinder Singh on 29/11/15.
//  Copyright © 2015 lakh. All rights reserved.
//

#import "FashionControl.h"
#import "FashionNewsCell.h"
#import "FashionStore.h"
#import "FashionNewsDetailControl.h"
#import "SVProgressHUD.h"
#import "LibOften.h"

@interface FashionControl ()<UICollectionViewDataSource, UICollectionViewDelegate> {
    NSMutableArray *items;
    NSInteger pageIndex;
}

@property (strong, nonatomic) IBOutlet UILabel *noDataFound;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
/// Pull-to-refresh control
@property (strong, nonatomic, readonly) UIRefreshControl *refreshControl;
@end

@implementation FashionControl
@synthesize refreshControl = _refreshControl;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initViews];
    pageIndex = 1;
    [SVProgressHUD show];
    [self loadNews];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)initViews {
    [self.collectionView addSubview:self.refreshControl];
    [self.collectionView setCollectionViewLayout:self.customLayout animated:YES];
    
    DefineWeakSelf;
    self.noDataFound.actionBlock = ^{
        [SVProgressHUD show];
        [weakSelf reload];
    };
    self.noDataFound.text = @"No news found!\nTap anywhere to refresh.";
}

- (UIRefreshControl *)refreshControl {
    if (!_refreshControl) {
        _refreshControl = [UIRefreshControl new];
        [_refreshControl addTarget:self action:@selector(reload) forControlEvents:UIControlEventValueChanged];
    } return _refreshControl;
}

- (void)reload {
    self.noDataFound.hidden = YES;
    [self requestItemsForFirstPage];
}

- (void)requestItemsForFirstPage {
    pageIndex = 1;
    [self loadNews];
}

- (void)requestItemsForNextPage {
    pageIndex ++;
    [SVProgressHUD show];
    [self loadNews];
}

- (void)loadNews {
    [[FashionStore shared] requestNews:pageIndex withCompletion:^(NSArray *news, NSError *error) {
        [SVProgressHUD dismiss];
        if (news.count == 0) {
            [SVProgressHUD showErrorWithStatus:@"No news found."];
        }
        if (pageIndex == 1) {
            items = [NSMutableArray new];
        }
        [items addObjectsFromArray:news];
        [self reloadData];
    }];
}

- (void)reloadData {
    self.noDataFound.hidden = items.count;
    [self.collectionView reloadData];
    [self.refreshControl endRefreshing];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma mark - Collection view delegates and some methods for collection view

- (UICollectionViewFlowLayout *)customLayout {
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.itemSize = [self cellSize];
    layout.minimumLineSpacing = 5;
    layout.minimumInteritemSpacing = 5;
    return layout;
}

- (CGSize)cellSize {
    return CGSizeMake(self.view.bounds.size.width, 100);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [items count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FashionNewsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ResueID" forIndexPath:indexPath];
    [cell updateWithModel:items[indexPath.row]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    FashionNewsDetailControl *detail = [FashionNewsDetailControl controlWithNews:items[indexPath.row]];
    [self.navigationController pushViewController:detail animated:YES];
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    BOOL lastItemReached = indexPath.item == items.count - 1;
    if (lastItemReached)
        dispatch_async_main(^{ // Avoid race condition
            [self requestItemsForNextPage];
        });
}

@end


