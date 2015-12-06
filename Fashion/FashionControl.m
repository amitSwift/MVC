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

@interface FashionControl ()<UICollectionViewDataSource, UICollectionViewDelegate> {
    NSArray *newsArray;
}

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation FashionControl

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.collectionView setCollectionViewLayout:self.customLayout animated:YES];
    [[FashionStore shared] requestNewsWithCompletion:^(NSArray *news, NSError *error) {
        newsArray = news;
        [self.collectionView reloadData];
    }];
    [self setNeedsStatusBarAppearanceUpdate];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (UICollectionViewFlowLayout *)customLayout { // FIXME: should convert to +[AbstractListControl collectionViewLayout]
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
    return [newsArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FashionNewsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ResueID" forIndexPath:indexPath];
    [cell updateWithModel:newsArray[indexPath.row]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    FashionNewsDetailControl *detail = [FashionNewsDetailControl controlWithNews:newsArray[indexPath.row]];
    [self.navigationController pushViewController:detail animated:YES];
}

@end




