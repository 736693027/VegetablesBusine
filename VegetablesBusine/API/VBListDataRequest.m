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
    VBListDataRequestType _requestType;
    NSInteger _tag;
}

- (instancetype)initWithPage:(NSInteger)page rows:(NSInteger)rows tag:(NSInteger)tag requestType:(VBListDataRequestType)requestType{
    self = [super init];
    if (self){
        _page = page;
        _rows = rows;
        _tag = tag;
        _requestType = requestType;
    }
    return self;
}

- (NSString *)requestUrl {
    if(_requestType == VBListDataRequestWaitDealNewOrder){
        return @"http://caibang.capsui.com/api/order/listOrders";
    }else if(_requestType == VBListDataRequestWaitDealRefund){
        return @"/api/orders/list";
    }else if (_requestType == VBListDataRequestEvaluationList){
        return @"/api/orderEvaluations/listview";
    }else{
        return @"/api/orders/list";
    }
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    return @{
             @"page":@(_page),
             @"rows":@(_rows),
             @"tab":@(_tag),
             @"sessionKey":@(_tag)
             };
}

@end
