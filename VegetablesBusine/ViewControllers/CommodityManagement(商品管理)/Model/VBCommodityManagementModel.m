//
//  VBCommodityManagementModel.m
//  VegetablesBusine
//
//  Created by Apple on 2018/12/12.
//  Copyright © 2018 Apple. All rights reserved.
//

#import "VBCommodityManagementModel.h"

@implementation VBCommodityManagementItemModel


@end

@implementation VBCommodityManagementModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"commodityInfo" : [VBCommodityManagementItemModel class]};
}

@end
