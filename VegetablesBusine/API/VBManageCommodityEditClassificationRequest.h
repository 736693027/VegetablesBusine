//
//  VBManageCommodityEditClassificationRequest.h
//  VegetablesBusine
//
//  Created by ldv on 2019/1/6.
//  Copyright © 2019年 Apple. All rights reserved.
//

#import "VBSessionKeyBaseRequest.h"
@class VBAddGoodsInfoModel;
@interface VBManageCommodityEditClassificationRequest : VBSessionKeyBaseRequest
- (instancetype)initWithGoodsInfoModel:(VBAddGoodsInfoModel *)model uploadImage:(UIImage *)uploadImage;
@end
