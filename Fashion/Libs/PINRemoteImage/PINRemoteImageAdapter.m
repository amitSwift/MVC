//
//  PINRemoteImageAdapter.m
//  Marquee
//
//  Created by Alexander Vasenin on 06/08/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

#import "PINRemoteImageAdapter.h"
#import "Pod/Classes/Image Categories/UIImageView+PINRemoteImage.h"
#import "NSURLSession.h"

@implementation UIImageView (PINRemoteImageAdapter)

- (void)setUrl:(NSURL *)url {
    [self setUrl:url placeholder:nil completion:NULL];
}

- (void)setUrl:(NSURL *)url placeholder:(UIImage *)placeholder {
    [self setUrl:url placeholder:placeholder completion:NULL];
}

- (void)setUrl:(NSURL *)url placeholder:(UIImage *)placeholder completion:(void(^)(NSError *))completion {
    if (url) {
        [self pin_setImageFromURL:url placeholderImage:placeholder completion:^(PINRemoteImageManagerResult *result){
            ExecuteNullableBlockSafely(completion, result.error);
        }];
    } else {
        self.image = placeholder;
    }
}

@end

////////////////////////////////////////////////////////////////////////////////

@implementation UIImage (PINRemoteImageAdapter)

+ (void)downloadImageFromUrl:(NSURL *)url completion:(void(^)(UIImage *))completion {
    [[PINRemoteImageManager sharedImageManager] downloadImageWithURL:url completion:^(PINRemoteImageManagerResult *result){
        if (completion)
            dispatch_async_main(^{
                completion(result.image);
            });
    }];
}

@end


