//
//  VBMerchantSettlementDataViewRequest.m
//  VegetablesBusine
//
//  Created by ldv on 2019/1/6.
//  Copyright © 2019年 Apple. All rights reserved.
//

#import "VBMerchantSettlementDataViewRequest.h"

@implementation VBMerchantSettlementDataViewRequest
{
    NSInteger _tab;
    NSInteger _currentPage;
}

- (instancetype)initWithTabNumber:(NSInteger)tab currentPage:(NSInteger)page {
    self = [super init];
    if(self){
        _tab = tab;
        _currentPage = page;
    }
    return self;
}

- (NSString *)requestUrl {
    return @"/api/seller/expenditureFlow";
}

- (id)requestArgument {
    return @{
             @"tab":@(_tab),
             @"sessionKey":OBJC(self.sessionKey),
             @"page":@(_currentPage)
             };
}

@end
