//
//  ProductCell.m
//  Fashion
//
//  Created by Rana on 22/12/15.
//  Copyright © 2015 lakh. All rights reserved.
//

#import "ProductCell.h"
#import "PINRemoteImageAdapter.h"
#import "Product.h"

@interface ProductCell ()
@property (strong, nonatomic) IBOutlet UIImageView *productImageView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *priceLabel;

@end

@implementation ProductCell

- (void)updateWithModel:(id)model {
    Product *product = model;
    self.nameLabel.text = product.title;
    self.priceLabel.text = [NSString stringWithFormat:@"€%@",product.price];
    [self.productImageView setUrl:product.imageUrl placeholder:[UIImage imageNamed:@"placeholder"]];
}

@end
