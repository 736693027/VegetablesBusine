

//
//  VBSetupStoreTypeRequest.m
//  VegetablesBusine
//
//  Created by Apple on 2018/12/24.
//  Copyright © 2018 Apple. All rights reserved.
//

#import "VBSetupStoreTypeRequest.h"

@implementation VBSetupStoreTypeRequest{
    NSString * _shopId;
    NSString * _storeTypeId;
}

- (instancetype)initWithShopId:(NSString *)shopId storeTypeId:(NSString *)storeTypeId{
    self = [super init];
    if(self){
        _shopId = shopId;
        _storeTypeId = storeTypeId;
    }
    return self;
}
- (NSString *)requestUrl {
    return @"/api/setting/storeTypesSet";
}

- (id)requestArgument {
    return @{
             @"shopId":OBJC(_shopId),
             @"storeTypeId":OBJC(_storeTypeId),
             @"sessionKey":OBJC(self.sessionKey),
             };
}
@end
