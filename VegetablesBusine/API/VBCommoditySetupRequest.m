//
//  VBCommoditySetupRequest.m
//  VegetablesBusine
//
//  Created by Apple on 2018/12/12.
//  Copyright © 2018 Apple. All rights reserved.
//

#import "VBCommoditySetupRequest.h"

@implementation VBCommoditySetupRequest
{
    NSString *_commodityId;
    NSString *_tab;
}

- (instancetype)initWithCommodityId:(NSString *)commodityId tab:(NSString *)tab{
    self = [super init];
    if(self){
        _commodityId = commodityId;
        _tab = tab;
    }
    return self;
}

- (NSString *)requestUrl {
    return @"/api/store/commodityOff";
}

- (id)requestArgument {
    return @{
             @"commodityId":OBJC(_commodityId),
             @"tab":OBJC(_tab),
             @"sessionKey":OBJC(self.sessionKey),
             };
}
@end
