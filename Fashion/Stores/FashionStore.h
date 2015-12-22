//
//  FashionStore.h
//  Fashion
//
//  Created by Lakhwinder Singh on 03/12/15.
//  Copyright © 2015 lakh. All rights reserved.
//

@import Foundation;
@class  News;

@interface FashionStore : NSObject
//! Singleton (shared instance)
+ (instancetype)shared;
//! Asynchronously returns news array
- (void)requestNews:(NSInteger)page withCompletion:(void(^)(NSArray *news, NSError *error))completion;
//! Asynchronously returns products array
- (void)requestProducts:(NSInteger)page categoryId:(NSInteger)catId withCompletion:(void(^)(NSArray *news, NSError *error))completion;
@end


