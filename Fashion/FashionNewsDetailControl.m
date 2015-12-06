//
//  FashionNewsDetailControl.m
//  Fashion
//
//  Created by Lakhwinder Singh on 05/12/15.
//  Copyright © 2015 lakh. All rights reserved.
//

#import "FashionNewsDetailControl.h"
#import "News.h"
#import "UIStoryboard.h"
@interface FashionNewsDetailControl ()
@property (strong, nonatomic) News *newsDetail;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UIImageView *imgVIew;
@property (strong, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollBack;

- (IBAction)commentButton:(id)sender;
- (IBAction)shareButton:(id)sender;
- (IBAction)backButton:(id)sender;
- (IBAction)backkButton:(id)sender;

@end

@implementation FashionNewsDetailControl

+ (instancetype)controlWithNews:(News *)news {
    FashionNewsDetailControl *control = [[UIStoryboard mainStoryboard] instantiateViewControllerWithIdentifier:@"FashionNewsDetail"];
    control.newsDetail = news;
    return control;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tabBarController.tabBar setHidden:YES];
    self.titleLabel.text = self.newsDetail.title;
    self.descriptionLabel.text = self.newsDetail.newsDescription;
    self.imgVIew.image = [UIImage imageNamed:self.newsDetail.imageUrl];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    CGRect contentRect = CGRectZero;
    for (UIView *view in self.scrollBack.subviews)
        contentRect = CGRectUnion(contentRect, view.frame);
    self.scrollBack.contentSize = contentRect.size;
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.tabBarController.tabBar setHidden:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)commentButton:(id)sender {
    
}

- (IBAction)shareButton:(id)sender {
    
}

- (IBAction)backButton:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)backkButton:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end


