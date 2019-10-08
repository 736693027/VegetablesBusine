//
//  VBGetManagerDetailByIDRequest.m
//  VegetablesBusine
//
//  Created by Apple on 2018/11/26.
//  Copyright © 2018 Apple. All rights reserved.
//

#import "VBGetManagerDetailByIDRequest.h"

@implementation VBGetManagerDetailByIDRequest{
    NSString *_idString;
}

- (instancetype)initWithIdString:(NSString *)idString{
    self = [super init];
    if (self){
        _idString = idString;
    }
    return self;
}

- (NSString *)requestUrl {
    NSString *urlPath = [NSString stringWithFormat:@"http://shangjiaduan.qsvc.caibangps.com/api/order/getOrder/{%@}/%@",_idString,[VMLoginUserInfoModel loginUsrInfoModel].sessionKey];
    return urlPath;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}

@end
