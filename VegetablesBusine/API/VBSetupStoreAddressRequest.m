//
//  VBSetupStoreAddressRequest.m
//  VegetablesBusine
//
//  Created by Apple on 2018/12/24.
//  Copyright © 2018 Apple. All rights reserved.
//

#import "VBSetupStoreAddressRequest.h"

@implementation VBSetupStoreAddressRequest{
    NSString * _remark;
    NSInteger _type;
}

- (instancetype)initWithRemark:(NSString *)remark type:(NSInteger)type{
    self = [super init];
    if(self){
        _remark = remark;
        _type = type;
    }
    return self;
}
- (NSString *)requestUrl {
    return @"/api/setting/storesAddress";
}

- (id)requestArgument {
    return @{
             @"remark":OBJC(_remark),
             @"type":@(_type),
             @"sessionKey":OBJC(self.sessionKey),
             };
}
@end
