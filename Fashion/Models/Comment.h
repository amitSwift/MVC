//
//  Comment.h
//  Fashion
//
//  Created by Rana on 28/12/15.
//  Copyright © 2015 lakh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Author.h"

@interface Comment : NSObject

+ (instancetype)commentFromJSON:(id)json;

@property (strong, nonatomic) NSString *commentId;

@property (strong, nonatomic) NSString *name;

@property (strong, nonatomic) NSString *commentContent;

@property (strong, nonatomic) NSString *url;

@property (strong, nonatomic) NSDate *date;

@property (strong, nonatomic) Author *author;
@end


