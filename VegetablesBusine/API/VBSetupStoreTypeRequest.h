//
//  VBSetupStoreTypeRequest.h
//  VegetablesBusine
//
//  Created by Apple on 2018/12/24.
//  Copyright © 2018 Apple. All rights reserved.
//

#import "VBSessionKeyBaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface VBSetupStoreTypeRequest : VBSessionKeyBaseRequest

- (instancetype)initWithShopId:(NSString *)shopId storeTypeId:(NSString *)storeTypeId;

@end

NS_ASSUME_NONNULL_END
