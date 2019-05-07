//
//  VBEvaluationReplyRequestAPI.m
//  VegetablesBusine
//
//  Created by Apple on 2018/12/24.
//  Copyright © 2018 Apple. All rights reserved.
//

#import "VBEvaluationReplyRequestAPI.h"

@implementation VBEvaluationReplyRequestAPI{
    NSString *_commentId;
    NSString *_content;
}

- (instancetype)initWithCommentId:(NSString *)commentId content:(NSString *)content{
    self = [super init];
    if(self){
        _commentId = commentId;
        _content = content;
    }
    return self;
}
- (NSString *)requestUrl {
    return @"/api/orderEvaluations/reply";
}

- (id)requestArgument {
    return @{
             @"commentId":OBJC(_commentId),
             @"content":OBJC(_content),
             @"sessionKey":OBJC(self.sessionKey),
             };
}
@end
