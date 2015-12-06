//
//  PINRemoteImageAdapter.h
//  Marquee
//
//  Created by Alexander Vasenin on 06/08/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

@import UIKit;

/**
 Adapter to PINRemoteImage+UIImageView
 */

@interface UIImageView (PINRemoteImageAdapter)

- (void)setUrl:(NSURL *)url;

- (void)setUrl:(NSURL *)url placeholder:(UIImage *)placeholder;

- (void)setUrl:(NSURL *)url placeholder:(UIImage *)placeholder completion:(void(^)(NSError *error))completion;

@end

////////////////////////////////////////////////////////////////////////////////

/**
 Adapter to PINRemoteImageManager
 */

@interface UIImage (PINRemoteImageAdapter)

+ (void)downloadImageFromUrl:(NSURL *)url completion:(void(^)(UIImage *img))completion;

@end


