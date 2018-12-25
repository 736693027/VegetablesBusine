//
//  VBGetActivityListRequest.m
//  VegetablesBusine
//
//  Created by Apple on 2018/12/25.
//  Copyright © 2018 Apple. All rights reserved.
//

#import "VBGetActivityListRequest.h"

@implementation VBGetActivityListRequest
{
    NSInteger _currentPage;
    NSInteger _tab;
}
- (instancetype)initWithCurrentPage:(NSInteger)currentPage tab:(NSInteger)tab{
    self = [super init];
    if(self){
        _currentPage = currentPage;
        _tab = tab;
    }
    return self;
}
- (NSString *)requestUrl {
    return @"/api/active/activeList";
}

- (id)requestArgument {
    return @{
             @"currentPage":@(_currentPage),
             @"pageSize":@(20),
             @"tab":@(_tab),
             @"sessionKey":OBJC(self.sessionKey),
             };
}
@end
