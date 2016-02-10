//
//  CommentScreenControl.m
//  Fashion
//
//  Created by Rana on 28/12/15.
//  Copyright © 2015 lakh. All rights reserved.
//

#import "CommentScreenControl.h"
#import "LibOften.h"
#import "CommentCell.h"
#import "Comment.h"
#import "UserStore.h"
#import "News.h"
#import "FashionStore.h"

@interface CommentScreenControl ()<UICollectionViewDataSource, UICollectionViewDelegate>  {
    NSMutableArray *items;
}
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) News *newsDetail;
@property (strong, nonatomic) IBOutlet UIToolbar *bottomToolbar;
@property (strong, nonatomic) IBOutlet UITextField *commentTextField;

- (IBAction)submitButton:(id)sender;
- (IBAction)backButton:(id)sender;
@end

@implementation CommentScreenControl

+ (instancetype)controlWithNews:(News *)news {
    CommentScreenControl *control = [[UIStoryboard mainStoryboard] instantiateViewControllerWithIdentifier:@"CommentScreenControl"];
    control.newsDetail = news;
    return control;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    items = [NSMutableArray new];
    [self.collectionView setCollectionViewLayout:self.customLayout animated:YES];
    [self.tabBarController.tabBar setHidden:YES];
    
    [SVProgressHUD show];
    [self loadComments];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma mark - Fetch Data

- (void)loadComments {
    [[FashionStore shared] requestCommentsForNews:self.newsDetail withCompletion:^(NSArray *comments, NSError *error) {
        if (comments && comments.count) {
            items = [NSMutableArray new];
            [items addObjectsFromArray:comments];
            [self.collectionView reloadData];
            [SVProgressHUD dismiss];
        }
        else {
            [SVProgressHUD showErrorWithStatus:@"No comments found."];
        }
    }];
}

#pragma mark - Button actions

- (IBAction)submitButton:(id)sender {
    if (!self.commentTextField.text.length) return;
    
    [SVProgressHUD show];
    [[UserStore shared] addComment:self.commentTextField.text postId:[self.newsDetail.newsId stringValue] withCompletion:^(BOOL success, NSError *error) {
        if (error || !success) {
            [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        }
        else {
            [SVProgressHUD showSuccessWithStatus:@"Comment posted successfully."];
            User *user = [[UserStore shared] getUser];
            Comment *comment = [Comment new];
            comment.name = user.userName;
            comment.commentContent = self.commentTextField.text;
            comment.date = [NSDate date];
            comment.url = user.url;
            [items addObject:comment];
            [self.collectionView reloadData];
            self.commentTextField.text = @"";
        }
    }];
}

- (IBAction)backButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
    CommentCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ResueID" forIndexPath:indexPath];
    [cell updateWithModel:items[indexPath.row]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.commentTextField resignFirstResponder];
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.commentTextField resignFirstResponder];
}

#pragma mark - Text field delegates + keyboard notificationsr

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:YES];
    
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.tabBarController.tabBar setHidden:NO];
    // unregister for keyboard notifications while not visible.
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}

-(void)keyboardWillShow:(NSNotification *)noti {
    // Animate the current view out of the way
    NSDictionary* info = [noti userInfo];
    CGSize keyboardSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    float duration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    [self.bottomToolbar setTranslatesAutoresizingMaskIntoConstraints:true];

    CGRect frameBottom = self.bottomToolbar.frame;
    frameBottom.origin.y = (self.view.frame.size.height-keyboardSize.height) -frameBottom.size.height;
    [UIView animateWithDuration:duration animations:^{
        self.bottomToolbar.frame = frameBottom;
    } completion:^(BOOL finished) {
        [self viewWillLayoutSubviews];
    }];

}

-(void)keyboardWillHide:(NSNotification *)noti {
    [self.bottomToolbar setTranslatesAutoresizingMaskIntoConstraints:false];
    [self viewWillLayoutSubviews];
}

@end


