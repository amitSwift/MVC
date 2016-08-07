//
//  ProductDetail.m
//  Fashion
//
//  Created by Rana on 22/12/15.
//  Copyright © 2015 lakh. All rights reserved.
//

#import "ProductDetail.h"
#import "Product.h"
#import "PINRemoteImageAdapter.h"
#import "ProductStore.h"
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
@property(nonatomic, strong, readwrite) PayPalConfiguration *payPalConfig;

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
    
    _payPalConfig = [[PayPalConfiguration alloc] init];
    _payPalConfig.acceptCreditCards = YES;
    _payPalConfig.merchantName = @"Fashion.ie";
    _payPalConfig.languageOrLocale = [NSLocale preferredLanguages][0];
    _payPalConfig.payPalShippingAddressOption = PayPalShippingAddressOptionPayPal;
     self.environment = kPayPalEnvironment;
    
    NSLog(@"%@",self.productDetail);
}

-(void)viewWillAppear:(BOOL)animated
{
    [self setPayPalEnvironment:self.environment];
}

- (void)viewDidAppear:(BOOL)animated {
    //[self.tabBarController.tabBar setHidden:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    //[self.tabBarController.tabBar setHidden:NO];
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

- (void)setPayPalEnvironment:(NSString *)environment {
    self.environment = environment;
    [PayPalMobile preconnectWithEnvironment:environment];
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buyNowTapped:(id)sender {
    if (self.productDetail.shippingRequired) {
        [SVProgressHUD show];
        [[ProductStore shared] requestShippingDetail:self.productDetail.shippingClassID withCompletion:^(Shipping *ship) {
            [SVProgressHUD dismiss];
            NSInteger price = [self.productDetail.price integerValue];
            NSInteger shipPrice = ship.count;
            [UIAlertView showWithTitle:@"Shipment amount required!" message:[NSString stringWithFormat:@"It will cost extra €%lu for shipment.", shipPrice] buttons:@[@"Cancel", @"Proceed"] completion:^(NSUInteger btn) {
                if (btn == 1) {
                    [self buyItem:[NSString stringWithFormat:@"%lu",price + shipPrice]];
                }
            }];
        }];
    } else {
        [self buyItem:self.productDetail.price];
    }
}

- (void)buyItem:(NSString *)price {
    PayPalItem *item = [PayPalItem itemWithName:self.productDetail.title
                                   withQuantity:1
                                      withPrice:[NSDecimalNumber decimalNumberWithString:price]
                                   withCurrency:@"EUR"
                                        withSku:self.productDetail.productCode];
    NSArray *items = @[item];
    
    NSDecimalNumber *total = [PayPalItem totalPriceForItems:items];
    
    
    PayPalPayment *payment = [[PayPalPayment alloc] init];
    payment.amount = total;
    payment.currencyCode = @"EUR";
    payment.shortDescription = self.productDetail.productDetails;
    payment.items = nil;  // if not including multiple items, then leave payment.items as nil
    payment.paymentDetails = nil; // if not including payment details, then leave payment.paymentDetails as nil
    
    // Update payPalConfig re accepting credit cards.
    self.payPalConfig.acceptCreditCards = self.acceptCreditCards;
    
    PayPalPaymentViewController *paymentViewController = [[PayPalPaymentViewController alloc] initWithPayment:payment
                                                                                                configuration:self.payPalConfig
                                                                                                     delegate:self];
    [self presentViewController:paymentViewController animated:YES completion:nil];
}

#pragma mark PayPalPaymentDelegate methods

- (void)payPalPaymentViewController:(PayPalPaymentViewController *)paymentViewController didCompletePayment:(PayPalPayment *)completedPayment
{
    NSLog(@"PayPal Payment Success!");
    self.resultText = [completedPayment description];
    
    [self sendCompletedPaymentToServer:completedPayment]; // Payment was processed successfully; send to server for verification and fulfillment
    [self dismissViewControllerAnimated:YES completion:^{
        [[[UIAlertView alloc] initWithTitle:@"Payment Successful" message:[NSString stringWithFormat:@"Thanks for buying %@", self.productDetail.title] delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil] show];
    }];
}

- (void)payPalPaymentDidCancel:(PayPalPaymentViewController *)paymentViewController {
    NSLog(@"PayPal Payment Canceled");
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark Proof of payment validation

- (void)sendCompletedPaymentToServer:(PayPalPayment *)completedPayment {
    // TODO: Send completedPayment.confirmation to server
    NSLog(@"Here is your proof of payment:\n\n%@\n\nSend this to your server for confirmation and fulfillment.", completedPayment.confirmation);
}

- (IBAction)backButton:(id)sender
{
    [self.tabBarController.tabBar setHidden:NO];
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
