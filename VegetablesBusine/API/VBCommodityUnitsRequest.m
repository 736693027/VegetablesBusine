//
//  VBCommodityUnitsRequest.m
//  VegetablesBusine
//
//  Created by ldv on 2019/1/5.
//  Copyright © 2019年 Apple. All rights reserved.
//

#import "VBCommodityUnitsRequest.h"

@implementation VBCommodityUnitsRequest
- (NSString *)requestUrl {
    return @"/api/store/commodityUnits";
}

- (id)requestArgument {
    return @{
             @"sessionKey":OBJC(self.sessionKey),
             };
}
@end
