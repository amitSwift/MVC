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
- (void)requestNewsWithCompletion:(void(^)(NSArray *news, NSError *error))completion;
@end


