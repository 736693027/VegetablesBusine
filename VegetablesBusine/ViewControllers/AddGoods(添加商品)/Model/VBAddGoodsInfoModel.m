//
//  VBAddGoodsInfoModel.m
//  VegetablesBusine
//
//  Created by Apple on 2018/12/13.
//  Copyright © 2018 Apple. All rights reserved.
//

#import "VBAddGoodsInfoModel.h"
#import "VBGoodsSpecificationsModel.h"

@implementation VBAddGoodsInfoModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"standards" : [VBGoodsSpecificationsItemModel class]};
}

@end
