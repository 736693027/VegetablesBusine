//
//  VBWaitDealListModel.m
//  VBWaitDealListModel
//
//  Created by apple on 18/11/26.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "VBWaitDealListModel.h"

@implementation VBWaitDealListModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    
    return @{@"listData" : [VBCommodityItemModel class]};
}

@end

@implementation VBCommodityItemModel


@end
