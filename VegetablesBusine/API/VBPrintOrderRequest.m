//
//  VBPrintOrderRequest.m
//  VegetablesBusine
//
//  Created by Apple on 2018/12/10.
//  Copyright © 2018 Apple. All rights reserved.
//

#import "VBPrintOrderRequest.h"

@implementation VBPrintOrderRequest{
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
    return @"http://caibang.capsui.com/api/order/printorders";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    return @{
             @"orderId":OBJC(_idString),
             @"sessionKey":OBJC(_idString)
             };
}
@end
