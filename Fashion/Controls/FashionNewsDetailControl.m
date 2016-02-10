//
//  FashionNewsDetailControl.m
//  Fashion
//
//  Created by Rana on 05/12/15.
//  Copyright © 2015 lakh. All rights reserved.
//

#import "FashionNewsDetailControl.h"
#import "News.h"
#import "LibOften.h"
#import "UserStore.h"
#import "CommentScreenControl.h"

@interface FashionNewsDetailControl ()
@property (strong, nonatomic) News *newsDetail;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UIWebView *descriptionWebView;
@property (strong, nonatomic) IBOutlet UILabel *editorNameLabel;

- (IBAction)commentButton:(id)sender;
- (IBAction)shareButton:(id)sender;
- (IBAction)backButton:(id)sender;

@end

@implementation FashionNewsDetailControl

+ (instancetype)controlWithNews:(News *)news {
    FashionNewsDetailControl *control = [[UIStoryboard mainStoryboard] instantiateViewControllerWithIdentifier:@"FashionDetail"];
    control.newsDetail = news;
    return control;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [SVProgressHUD show];
    [self.tabBarController.tabBar setHidden:YES];
    self.titleLabel.text = self.newsDetail.title;
    self.dateLabel.text = self.newsDetail.date;
    self.editorNameLabel.text = self.newsDetail.author.name;
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [self.tabBarController.tabBar setHidden:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    [self.descriptionWebView loadHTMLString:self.newsDetail.contentWeb baseURL:nil];
    [SVProgressHUD dismiss];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.tabBarController.tabBar setHidden:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)commentButton:(id)sender {
    if (![[UserStore shared] isLoggedIn]) {
        DefineWeakSelf;
        [UIAlertView showWithTitle:@"Alert!" message:@"You have to login first." buttons:@[@"Cancel", @"Login"] completion:^(NSUInteger buttonIndex) {
            if (buttonIndex == 1) {
                [weakSelf presentViewController:[[UIStoryboard mainStoryboard] instantiateViewControllerWithIdentifier:@"SignInSignUpControl"] animated:YES completion:nil];
            }
        }];
    }
    else {
        CommentScreenControl *commentScreen = [CommentScreenControl controlWithNews:self.newsDetail];
        [self.navigationController pushViewController:commentScreen animated:YES];
    }
}

- (IBAction)shareButton:(id)sender {
    NSString *noteStr = [NSString stringWithFormat:@"%@", self.newsDetail.title];
    
    NSURL *url = [NSURL URLWithString:self.newsDetail.newsURL];
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:@[noteStr, url] applicationActivities:nil];
    [self presentViewController:activityVC animated:YES completion:nil];
}

- (IBAction)backButton:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(BOOL) webView:(UIWebView *)inWeb shouldStartLoadWithRequest:(NSURLRequest *)inRequest navigationType:(UIWebViewNavigationType)inType {
    if (inType == UIWebViewNavigationTypeLinkClicked) {
        [[UIApplication sharedApplication] openURL:[inRequest URL]];
        return NO;
    }
    return YES;
}

@end


