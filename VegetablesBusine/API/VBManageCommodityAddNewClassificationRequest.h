//
//  VBManageCommodityAddNewClassificationRequest.h
//  VegetablesBusine
//
//  Created by Apple on 2018/12/12.
//  Copyright © 2018 Apple. All rights reserved.
//

#import "VBSessionKeyBaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface VBManageCommodityAddNewClassificationRequest : VBSessionKeyBaseRequest

- (instancetype)initWithClassificationId:(NSString *)classificationId classificationName:(NSString *)classificationName number:(NSString *)number;

@end

NS_ASSUME_NONNULL_END
