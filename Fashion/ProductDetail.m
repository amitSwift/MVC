//
//  ProductDetail.m
//  Fashion
//
//  Created by Lakhwinder Singh on 22/12/15.
//  Copyright © 2015 lakh. All rights reserved.
//

#import "ProductDetail.h"
#import "Product.h"
#import "PINRemoteImageAdapter.h"
#import "LibOften.h"

@interface ProductDetail ()
@property (strong, nonatomic) Product *productDetail;
- (IBAction)backButton:(id)sender;

@property (strong, nonatomic) IBOutlet UIImageView *productImageView;
@property (strong, nonatomic) IBOutlet UILabel *productName;
@property (strong, nonatomic) IBOutlet UILabel *sellerInformationLabel;
@property (strong, nonatomic) IBOutlet UILabel *productDescriptionLabel;
@property (strong, nonatomic) IBOutlet UILabel *additionalInformationLabel;
@property (strong, nonatomic) IBOutlet UILabel *shippingInfoLabel;
@property (strong, nonatomic) IBOutlet UILabel *shippingPolicyLabel;
@property (strong, nonatomic) IBOutlet UILabel *refundPolicyLabel;

@property (strong, nonatomic) IBOutlet UIButton *buyButton;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;


@end

@implementation ProductDetail

+ (instancetype)controlWithProduct:(Product *)product {
    ProductDetail *control = [[UIStoryboard mainStoryboard] instantiateViewControllerWithIdentifier:@"ProductDetail"];
    control.productDetail = product;
    return control;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tabBarController.tabBar setHidden:YES];
    [self loadData];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    [self.tabBarController.tabBar setHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.tabBarController.tabBar setHidden:NO];
}

- (void)loadData {
    self.productName.text = self.productDetail.title;
    self.sellerInformationLabel.text = self.productDetail.sellerDetails;
    self.productDescriptionLabel.attributedText =
    [[NSAttributedString alloc]
     initWithData: [self.productDetail.productDetails dataUsingEncoding:NSUTF8StringEncoding]
     options: @{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType}
     documentAttributes: nil error:nil];
    self.shippingInfoLabel.text = self.productDetail.shipInfo;
    self.shippingPolicyLabel.text = self.productDetail.shippingPolicy;
    self.refundPolicyLabel.text = self.productDetail.refundPolicy;
    self.additionalInformationLabel.attributedText = [self getAttributedString:self.productDetail.additionalInformation];
    [self.productImageView setUrl:self.productDetail.imageUrl placeholder:[UIImage imageNamed:@"placeholder"]];
    self.buyButton.title = [NSString stringWithFormat:@"Buy for €%@", self.productDetail.price];
}

#define DEFAULT_MESSAGE_ATTRIBUTES @{NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue" size:14.0]}
#define HIGHLIGHT_MESSAGE_ATTRIBUTES @{NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue-Medium" size:14.0]}

- (NSAttributedString *)getAttributedString:(NSDictionary *)dict {
    NSMutableAttributedString *mutAttString = [NSMutableAttributedString new];
    NSAttributedString *nextLine = [[NSAttributedString alloc] initWithString:@"\n" attributes:DEFAULT_MESSAGE_ATTRIBUTES];
    for (NSString *key in dict.allKeys) {
        if ([[mutAttString string] length]) {
            [mutAttString appendAttributedString:nextLine];
        }
        [mutAttString appendAttributedString:[self createAttributedStringHeader:key andValue:dict[key]]];
    }
    return mutAttString;
}

- (NSAttributedString *)createAttributedStringHeader:(NSString *)title andValue:(NSString *)value {
    NSAttributedString *highlightedMessage = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@: ",title] attributes:HIGHLIGHT_MESSAGE_ATTRIBUTES];
    NSAttributedString *plainMessage = [[NSAttributedString alloc] initWithString:value attributes:DEFAULT_MESSAGE_ATTRIBUTES];

    NSMutableAttributedString *mutAttString = [NSMutableAttributedString new];
    [mutAttString appendAttributedString:highlightedMessage];
    [mutAttString appendAttributedString:plainMessage];
    return mutAttString;
}

- (void)viewDidLayoutSubviews {
    CGFloat scrollViewHeight = 0.0f;
    for (UIView* view in self.scrollView.subviews)
    {
        scrollViewHeight += view.frame.size.height;
    }
    
    [self.scrollView setContentSize:(CGSizeMake(self.scrollView.bounds.size.width, scrollViewHeight+64))];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backButton:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
