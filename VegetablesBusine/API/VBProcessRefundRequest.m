//
//  VBProcessRefundRequest.m
//  VegetablesBusine
//
//  Created by Apple on 2018/11/26.
//  Copyright © 2018 Apple. All rights reserved.
//

#import "VBProcessRefundRequest.h"

@implementation VBProcessRefundRequest{
    NSString *_idString;
    NSInteger _type;
}

- (instancetype)initWithIdString:(NSString *)idString type:(NSInteger)type{
    self = [super init];
    if (self){
        _idString = idString;
        _type = type;
    }
    return self;
}

- (NSString *)requestUrl {
    return @"/api/pendingOrder/refund";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    return @{
             @"sessionKey":OBJC([VMLoginUserInfoModel loginUsrInfoModel].sessionKey),
             @"orderId":OBJC(_idString),
             @"tab":@(_type),
             };
}
@end
