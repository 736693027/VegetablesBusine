//
//  VBManageCommodityEditClassificationRequest.m
//  VegetablesBusine
//
//  Created by ldv on 2019/1/6.
//  Copyright © 2019年 Apple. All rights reserved.
//

#import "VBManageCommodityEditClassificationRequest.h"
#import "VBAddGoodsInfoModel.h"
@implementation VBManageCommodityEditClassificationRequest
{
    VBAddGoodsInfoModel *innerModel;
}

- (instancetype)initWithGoodsInfoModel:(VBAddGoodsInfoModel *)model{
    if (self = [super init]) {
        innerModel = model;
    }
    return self;
}

- (NSString *)requestUrl {
    return @"/api/store/commodityEdit";
}

- (id)requestArgument {
    NSString *standardsString = [innerModel.standards componentsJoinedByString:@","];
    NSDictionary *dic = @{
                          @"name":OBJC(innerModel.name),
                          @"subtitle":OBJC(innerModel.subtitle),
                          @"commodityID":OBJC(innerModel.commodityID),
                          @"price":OBJC(innerModel.price),
                          @"foodContainerPrice":OBJC(innerModel.foodContainerPrice),
                          @"uniti":OBJC(innerModel.uniti),
                          @"classifyID":OBJC(innerModel.classifyID),
                          @"standards":OBJC(standardsString),
                          @"inventory":OBJC(innerModel.inventory),
                          @"sessionKey":OBJC(self.sessionKey)
                          };
    return dic;
}

@end
