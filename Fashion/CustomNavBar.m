//
//  CustomNavBar.m
//  Fashion
//
//  Created by Lakhwinder Singh on 29/11/15.
//  Copyright © 2015 lakh. All rights reserved.
//

#import "CustomNavBar.h"

@implementation CustomNavBar

@synthesize backImageView = _backImageView;

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self addSubview:self.backImageView];
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

#pragma mark overrided methods

- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.backImageView) {
        CGRect frame = self.frame;
        frame.size.width = self.backImageView.image.size.width;
        frame.origin.x = self.center.x - frame.size.width/2;
        frame.origin.y = 0;
        self.backImageView.frame = frame;
    }
}

@end


