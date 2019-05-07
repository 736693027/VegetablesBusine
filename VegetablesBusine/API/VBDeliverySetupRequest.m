//
//  VBDeliverySetupRequest.m
//  VegetablesBusine
//
//  Created by Apple on 2018/12/24.
//  Copyright © 2018 Apple. All rights reserved.
//

#import "VBDeliverySetupRequest.h"

@implementation VBDeliverySetupRequest{
    NSString *_price;
    NSString *_cateringTime;
    NSString *_deliveryTime;
}
- (instancetype)initWithPrice:(NSString *)price cateringTime:(NSString *)cateringTime deliveryTime:(NSString *)deliveryTime{
    self = [super init];
    if(self){
        _price = price;
        _cateringTime = cateringTime;
        _deliveryTime = deliveryTime;
    }
    return self;
}
- (NSString *)requestUrl {
    return @"/api/setting/deliverySet";
}

- (id)requestArgument {
    return @{
             @"price":OBJC(_price),
             @"cateringTime":OBJC(_cateringTime),
             @"deliveryTime":OBJC(_deliveryTime),
             @"sessionKey":OBJC(self.sessionKey),
             };
}
@end
