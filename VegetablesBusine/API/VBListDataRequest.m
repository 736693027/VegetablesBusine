//
//  VBListDataRequest.m
//  VegetablesBusine
//
//  Created by Apple on 2018/11/26.
//  Copyright © 2018 Apple. All rights reserved.
//

#import "VBListDataRequest.h"

@implementation VBListDataRequest{
    NSInteger _page;
    NSInteger _rows;
}

- (instancetype)initWithPage:(NSInteger)page rows:(NSInteger)rows{
    self = [super init];
    if (self){
        _page = page;
        _rows = rows;
    }
    return self;
}

- (NSString *)requestUrl {
    return @"/api/orders/list";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    return @{
             @"page":@(_page),
             @"rows":@(_rows)
             };
}

@end
