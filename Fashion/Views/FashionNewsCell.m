//
//  FashionNewsCell.m
//  Fashion
//
//  Created by Lakhwinder Singh on 03/12/15.
//  Copyright © 2015 lakh. All rights reserved.
//

#import "FashionNewsCell.h"
#import "News.h"

@interface FashionNewsCell ()

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (strong, nonatomic) IBOutlet UIImageView *imgView;

@end

@implementation FashionNewsCell

- (void)updateWithModel:(id)model {
    News *news = model;
    self.titleLabel.text = news.title;
    self.descriptionLabel.text = news.newsDescription;
    self.imgView.image = [UIImage imageNamed:news.imageUrl];
}

@end


