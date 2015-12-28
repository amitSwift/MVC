//
//  Author.m
//  Fashion
//
//  Created by Lakhwinder Singh on 27/12/15.
//  Copyright © 2015 lakh. All rights reserved.
//

#import "Author.h"

@implementation Author

+ (instancetype)authorFromJSON:(id)json {
    Author *author = [Author new];
    author.authorId = json[@"id"];
    author.slug = json[@"slug"];
    author.name = json[@"name"];
    author.firstName = json[@"first_name"];
    author.lastName = json[@"last_name"];
    author.nickname = json[@"nickname"];
    author.url = json[@"url"];
    author.authorDescription = json[@"description"];
    return author;
}

@end


