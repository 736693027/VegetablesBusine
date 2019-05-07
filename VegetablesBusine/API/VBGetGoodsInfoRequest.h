//
//  VBGetGoodsInfoRequest.h
//  VegetablesBusine
//
//  Created by Apple on 2018/12/13.
//  Copyright © 2018 Apple. All rights reserved.
//

#import "VBSessionKeyBaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface VBGetGoodsInfoRequest : VBSessionKeyBaseRequest

- (instancetype)initWithCommodityId:(NSString *)commodityId;

@end

NS_ASSUME_NONNULL_END
