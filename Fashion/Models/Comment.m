
//
//  Comment.m
//  Fashion
//
//  Created by Lakhwinder Singh on 28/12/15.
//  Copyright © 2015 lakh. All rights reserved.
//

#import "Comment.h"
#import "LibOften.h"

@implementation Comment

+ (instancetype)commentFromJSON:(id)json {
    Comment *comment = [Comment new];
    comment.commentId = json[@"id"];
    comment.name = json[@"name"];
    comment.url = json[@"url"];
    comment.commentContent = json[@"content"];
    comment.date = [NSDate dateFromString:json[@"date"] withFormat:@"yyyy-MM-dd HH:mm:ss" timeZone:[NSTimeZone timeZoneWithName:@"Europe/London"]];//2015-12-22 17:43:53
    comment.author = [Author authorFromJSON:json[@"author"]];
    return comment;
}

@end


