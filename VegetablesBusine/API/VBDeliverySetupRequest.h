//
//  VBDeliverySetupRequest.h
//  VegetablesBusine
//
//  Created by Apple on 2018/12/24.
//  Copyright © 2018 Apple. All rights reserved.
//

#import "VBSessionKeyBaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface VBDeliverySetupRequest : VBSessionKeyBaseRequest

- (instancetype)initWithPrice:(NSString *)price cateringTime:(NSString *)cateringTime deliveryTime:(NSString *)deliveryTime;

@end

NS_ASSUME_NONNULL_END
