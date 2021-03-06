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
    if(_requestType == VBListDataRequestWaitDealNewOrder || _requestType == VBListDataRequestWaitDealRefund){
        return @"/api/pendingOrder/orders";
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
             @"currentPage":@(_page),
             @"pageSize":@(_rows),
             @"tab":@(_tag),
             @"sessionKey":OBJC([VMLoginUserInfoModel loginUsrInfoModel].sessionKey)
             };
}

@end
