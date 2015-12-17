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

@interface MarketPlaceControl ()<CategoriesTableDelegate> {
    BOOL isMenuShow;
}
@property (strong, nonatomic, readonly) CategoriesTableControl *categoriesTableControl;
@property (strong, nonatomic) IBOutlet UIView *viewBack;
@property (strong, nonatomic) IBOutlet UILabel *lblNoProductsFound;

- (IBAction)menuButton:(id)sender;

@end

@implementation MarketPlaceControl
@synthesize categoriesTableControl = _categoriesTableControl;

- (void)viewDidLoad {
    [super viewDidLoad];
    isMenuShow = YES;
    [self.viewBack addSubview:self.categoriesTableControl.view];
    
    self.lblNoProductsFound.hidden = NO;
    self.lblNoProductsFound.text = @"No prodcuts found!\nTap anywhere to refresh.";
    
    self.lblNoProductsFound.actionBlock = ^{
    };
    // Do any additional setup after loading the view.
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
        
    }];
}

- (void)updateViewConstraints {
    NSDictionary *views = @{@"categoriesTable":self.categoriesTableControl.view};
    [self.viewBack addVisualConstraints:@[@"H:|[categoriesTable]|", @"V:|[categoriesTable]|"] forSubviews:views];
    [super updateViewConstraints];
}

@end


