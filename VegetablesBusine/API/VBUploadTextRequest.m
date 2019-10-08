//
//  VBUploadTextRequest.m
//  VegetablesBusine
//
//  Created by Apple on 2018/11/26.
//  Copyright © 2018 Apple. All rights reserved.
//

#import "VBUploadTextRequest.h"

@implementation VBUploadTextRequest{
    NSString *_text;
    NSInteger _type;
}

- (instancetype)initWithText:(NSString *)text type:(NSInteger)type{
    self = [super init];
    if (self){
        _text = text;
        _type = type;
    }
    return self;
}

- (NSString *)requestUrl {
    return @"/api/setting/storesAddress";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    return @{
             @"remark":OBJC(_text),
             @"type":@(_type),
             @"sessionKey":OBJC([VMLoginUserInfoModel loginUsrInfoModel].sessionKey)
             };
}

@end
