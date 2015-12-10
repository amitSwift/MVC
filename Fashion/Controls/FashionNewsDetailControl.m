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
#import "GCD.h"
#import "SVProgressHUD.h"

@interface FashionNewsDetailControl ()
@property (strong, nonatomic) News *newsDetail;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UITextView *descriptionView;
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

- (void)viewDidAppear:(BOOL)animated {
    self.descriptionView.attributedText =
    [[NSAttributedString alloc] initWithData: [self.newsDetail.contentWeb dataUsingEncoding:NSUTF8StringEncoding]
                                     options: @{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType }
                          documentAttributes: nil error:nil];
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
    
}

- (IBAction)shareButton:(id)sender {
    
}

- (IBAction)backButton:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end

