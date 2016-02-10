//
//  FashionStore.h
//  Fashion
//
//  Created by Rana on 03/12/15.
//  Copyright © 2015 lakh. All rights reserved.
//

@import Foundation;
@class  News;

@interface FashionStore : NSObject
//! Singleton (shared instance)
+ (instancetype)shared;
//! Asynchronously returns news array
- (void)requestNews:(NSInteger)page withCompletion:(void(^)(NSArray *news, NSError *error))completion;
//! Asynchronously returns product comments
- (void)requestCommentsForNews:(News *)news withCompletion:(void(^)(NSArray *comments, NSError *error))completion;
@end


