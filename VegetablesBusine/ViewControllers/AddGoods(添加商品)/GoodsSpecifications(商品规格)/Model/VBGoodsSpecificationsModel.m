//
//  VBGoodsSpecificationsModel.m
//  VegetablesBusine
//
//  Created by Apple on 2018/12/12.
//  Copyright © 2018 Apple. All rights reserved.
//

#import "VBGoodsSpecificationsModel.h"

@implementation VBGoodsSpecificationsItemModel


@end

@implementation VBGoodsSpecificationsModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"standardsInfo" : [VBGoodsSpecificationsItemModel class]};
}
@end
