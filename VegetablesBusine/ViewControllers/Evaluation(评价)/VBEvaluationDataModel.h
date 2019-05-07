//
//  VBEvaluationDataModel.h
//  VegetablesBusine
//
//  Created by Apple on 2018/12/24.
//  Copyright © 2018 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VBEvaluationDataModel : NSObject

@property (copy, nonatomic) NSString *commentId; //评论ID
@property (copy ,nonatomic) NSString *imageUrl;
@property (copy ,nonatomic) NSString *name;
@property (copy ,nonatomic) NSString *commodityName;
@property (copy ,nonatomic) NSString *star;
@property (copy ,nonatomic) NSString *dataTime;
@property (copy ,nonatomic) NSString *content;
@property (copy ,nonatomic) NSString *isReply;
@property (copy ,nonatomic) NSString *replyContent;
@property (copy ,nonatomic) NSString *replyTime;

@end

NS_ASSUME_NONNULL_END
