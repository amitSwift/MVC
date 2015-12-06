//
//  FashionNewsCell.m
//  Fashion
//
//  Created by Lakhwinder Singh on 03/12/15.
//  Copyright © 2015 lakh. All rights reserved.
//

#import "FashionNewsCell.h"
#import "News.h"
#import "PINRemoteImageAdapter.h"

@interface FashionNewsCell ()

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (strong, nonatomic) IBOutlet UIImageView *imgView;

@end

@implementation FashionNewsCell

- (void)updateWithModel:(id)model {
    News *news = model;
    self.titleLabel.text = news.title;
    self.descriptionLabel.text = @"";
//    self.descriptionLabel.attributedText =
//    [[NSAttributedString alloc]
//     initWithData: [news.contentWeb dataUsingEncoding:NSUTF8StringEncoding]
//     options: @{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType }
//     documentAttributes: nil error:nil];
    
    [self.imgView setUrl:[NSURL URLWithString:news.imageUrl] placeholder:nil];
}

@end


