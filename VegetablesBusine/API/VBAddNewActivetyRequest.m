//
//  VBAddNewActivetyRequest.m
//  VegetablesBusine
//
//  Created by Apple on 2018/12/25.
//  Copyright © 2018 Apple. All rights reserved.
//

#import "VBAddNewActivetyRequest.h"

@implementation VBAddNewActivetyRequest
{
    NSString *_parameter;
}
- (instancetype)initWithRuleParameter:(NSString *)parameter{
    self = [super init];
    if(self){
        _parameter = parameter;
    }
    return self;
}
- (NSString *)requestUrl {
    return @"/api/active/activeAdd";
}

- (id)requestArgument {
    return @{
             @"bean":OBJC(_parameter),
             @"sessionKey":OBJC(self.sessionKey),
             };
}
@end
