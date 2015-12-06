//
//  CustomNavBar.m
//  Fashion
//
//  Created by Lakhwinder Singh on 29/11/15.
//  Copyright © 2015 lakh. All rights reserved.
//

#import "CustomNavBar.h"

@interface CustomNavBar ()
@property (readonly) UIView *wrapperView;
@property (readonly) UIImageView *backImageView;
@end

@implementation CustomNavBar

@synthesize wrapperView = _wrapperView, backImageView = _backImageView;

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self addSubview:self.wrapperView];
        [self addSubview:self.backImageView];
    } return self;
}

#pragma mark getters and setters

- (UIView *)wrapperView {
    if (!_wrapperView) {
        _wrapperView = [UIView new];
    } return _wrapperView;
}

- (UIImageView *)backImageView {
    if (!_backImageView) {
        _backImageView = [UIImageView new];
        _backImageView.image = [UIImage imageNamed:@"topLogo"];
        _backImageView.contentMode = UIViewContentModeCenter;
    } return _backImageView;
}

#pragma mark overrided methods

- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.wrapperView) {
        self.wrapperView.frame = self.bounds;
        self.backImageView.frame = self.bounds;
    }
}

@end


