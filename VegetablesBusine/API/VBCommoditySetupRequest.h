//
//  VBCommoditySetupRequest.h
//  VegetablesBusine
//
//  Created by Apple on 2018/12/12.
//  Copyright © 2018 Apple. All rights reserved.
//

#import "VBSessionKeyBaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface VBCommoditySetupRequest : VBSessionKeyBaseRequest

- (instancetype)initWithCommodityId:(NSString *)commodityId tab:(NSString *)tab;

@end

NS_ASSUME_NONNULL_END
