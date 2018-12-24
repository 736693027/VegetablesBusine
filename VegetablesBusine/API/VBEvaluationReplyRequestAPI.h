//
//  VBEvaluationReplyRequestAPI.h
//  VegetablesBusine
//
//  Created by Apple on 2018/12/24.
//  Copyright © 2018 Apple. All rights reserved.
//

#import "VBSessionKeyBaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface VBEvaluationReplyRequestAPI : VBSessionKeyBaseRequest

- (instancetype)initWithCommentId:(NSString *)commentId content:(NSString *)content;

@end

NS_ASSUME_NONNULL_END
