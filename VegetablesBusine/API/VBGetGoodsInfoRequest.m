//
//  VBGetGoodsInfoRequest.m
//  VegetablesBusine
//
//  Created by Apple on 2018/12/13.
//  Copyright © 2018 Apple. All rights reserved.
//

#import "VBGetGoodsInfoRequest.h"

@implementation VBGetGoodsInfoRequest
{
    NSString *_commodityId;
}

- (instancetype)initWithCommodityId:(NSString *)commodityId{
    self = [super init];
    if(self){
        _commodityId = commodityId;
    }
    return self;
}

- (NSString *)requestUrl {
    return @"/api/store/commodityDetail";
}

- (id)requestArgument {
    return @{
             @"commodityId":OBJC(_commodityId),
             @"sessionKey":OBJC(self.sessionKey),
             };
}
@end
