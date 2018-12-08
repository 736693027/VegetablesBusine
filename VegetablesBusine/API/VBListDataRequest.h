//
//  VBListDataRequest.h
//  VegetablesBusine
//
//  Created by Apple on 2018/11/26.
//  Copyright © 2018 Apple. All rights reserved.
//

#import "LBBaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, VBListDataRequestType) {
    VBListDataRequestWaitDealNewOrder = 1, //待处理新订单
    VBListDataRequestWaitDealRefund ,//待处理退款
};

@interface VBListDataRequest : LBBaseRequest

- (instancetype)initWithPage:(NSInteger)page rows:(NSInteger)rows tag:(NSInteger)tag requestType:(VBListDataRequestType)requestType;

@end

NS_ASSUME_NONNULL_END
