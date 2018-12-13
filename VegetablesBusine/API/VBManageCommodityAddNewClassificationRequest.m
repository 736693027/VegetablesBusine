//
//  VBManageCommodityAddNewClassificationRequest.m
//  VegetablesBusine
//
//  Created by Apple on 2018/12/12.
//  Copyright © 2018 Apple. All rights reserved.
//

#import "VBManageCommodityAddNewClassificationRequest.h"

@implementation VBManageCommodityAddNewClassificationRequest{
    NSString *_classificationId;
    NSString *_classificationName;
    NSString *_number;
}

- (instancetype)initWithClassificationId:(NSString *)classificationId classificationName:(NSString *)classificationName number:(NSString *)number{
    self = [super init];
    if(self){
        _classificationId = classificationId;
        _classificationName = classificationName;
        _number = number;
    }
    return self;
}

- (NSString *)requestUrl {
    return @"http://caibang.capsui.com/api/store/commodityTypesAdd";
}

- (id)requestArgument {
    return @{
             @"classifyName":OBJC(_classificationName),
             @"number":OBJC(_number),
             @"classifyID":OBJC(_classificationId),
             @"sessionKey":OBJC(self.sessionKey),
             };
}
@end
