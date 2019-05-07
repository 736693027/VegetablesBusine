//
//  VBSessionKeyBaseRequest.m
//  VegetablesBusine
//
//  Created by Apple on 2018/12/11.
//  Copyright © 2018 Apple. All rights reserved.
//

#import "VBSessionKeyBaseRequest.h"
#import "VMLoginUserInfoModel.h"

@implementation VBSessionKeyBaseRequest

- (instancetype)init{
    self = [super init];
    if (self){
        _sessionKey = [VMLoginUserInfoModel loginUsrInfoModel].sessionKey;
    }
    return self;
}

- (NSString *)requestUrl {
    return @"";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    return @{
             @"sessionKey":OBJC(_sessionKey)
             };
}
@end
