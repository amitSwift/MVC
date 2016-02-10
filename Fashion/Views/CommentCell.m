//
//  CommentCell.m
//  Fashion
//
//  Created by Rana on 28/12/15.
//  Copyright © 2015 lakh. All rights reserved.
//

#import "CommentCell.h"
#import "Comment.h"
#import "PINRemoteImageAdapter.h"
#import "LibOften.h"

@interface CommentCell ()
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (strong, nonatomic) IBOutlet UIImageView *imgProfile;

@end

@implementation CommentCell

- (void)updateWithModel:(id)model {
    Comment *comment = model;
    self.titleLabel.text = comment.name;
    self.dateLabel.text = [NSString stringWithFormat:@"%@ at %@",[comment.date stringWithFormat:@"MMMM dd, yyyy"], [comment.date stringWithFormat:@"hh:mm a"]];
    dispatch_async_main(^{
        self.descriptionLabel.attributedText =
        [[NSAttributedString alloc]
         initWithData: [comment.commentContent dataUsingEncoding:NSUTF8StringEncoding]
         options: @{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType }
         documentAttributes: nil error:nil];
    });
    [self.imgProfile setUrl:[NSURL URLWithString:comment.url] placeholder:[UIImage imageNamed:@"profilePicHolder"]];
}

@end
