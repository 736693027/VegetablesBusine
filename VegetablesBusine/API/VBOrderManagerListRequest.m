//
//  VBOrderManagerListRequest.m
//  VegetablesBusine
//
//  Created by Apple on 2018/12/25.
//  Copyright © 2018 Apple. All rights reserved.
//

#import "VBOrderManagerListRequest.h"

@implementation VBOrderManagerListRequest{
    NSInteger _currentPage;
    NSString *_startDate;
    NSInteger _tab;
}
- (instancetype)initWithCurrentPage:(NSInteger)currentPage startDate:(NSString *)startDate tab:(NSInteger)tab{
    self = [super init];
    if(self){
        
    }
    return self;
}
- (NSString *)requestUrl {
    return @"/api/order/listOrders";
}

- (id)requestArgument {
    return @{
             @"currentPage":@(_currentPage),
             @"pageSize":@(20),
             @"startDate":OBJC(_startDate),
             @"tab":@(_tab),
             @"sessionKey":OBJC(self.sessionKey),
             };
}
@end
