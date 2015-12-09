//
//  CustomNavBar.m
//  Fashion
//
//  Created by Lakhwinder Singh on 29/11/15.
//  Copyright © 2015 lakh. All rights reserved.
//

#import "MarketPlaceNavBar.h"
#import "LibOften.h"

@interface MarketPlaceNavBar ()

@property (readonly) UIImageView *backImageView;

@property (readonly) UIButton *menuButton;

@end

@implementation MarketPlaceNavBar

@synthesize backImageView = _backImageView, menuButton = _menuButton;

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self addSubviews:@[self.backImageView, self.menuButton]];
    } return self;
}

#pragma mark getters and setters

- (UIImageView *)backImageView {
    if (!_backImageView) {
        _backImageView = [UIImageView new];
        _backImageView.image = [UIImage imageNamed:@"topLogo"];
        _backImageView.contentMode = UIViewContentModeCenter;
    } return _backImageView;
}

- (UIButton *)menuButton {
    if (!_menuButton) {
        _menuButton = [UIButton new];
        _menuButton.image = [UIImage imageNamed:@"menuIcon"];
    } return _menuButton;
}

#pragma mark overrided methods

- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.backImageView) {
        CGRect frame = self.frame;
        
        self.menuButton.frame = CGRectMake(frame.size.width-50, 0, 50, frame.size.height);
        
        frame.size.width = self.backImageView.image.size.width;
        frame.origin.x = self.center.x - frame.size.width/2;
        frame.origin.y = 0;
        self.backImageView.frame = frame;
    }
}

@end


