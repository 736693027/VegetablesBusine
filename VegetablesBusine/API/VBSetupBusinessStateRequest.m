//
//  VBSetupBusinessStateRequest.m
//  VegetablesBusine
//
//  Created by Apple on 2018/12/24.
//  Copyright © 2018 Apple. All rights reserved.
//

#import "VBSetupBusinessStateRequest.h"

@implementation VBSetupBusinessStateRequest{
    NSInteger _businessState;
}

- (instancetype)initWithBusinessState:(NSInteger)businessState{
    self = [super init];
    if(self){
        _businessState = businessState;
    }
    return self;
}
- (NSString *)requestUrl {
    return @"/api/setting/businessStatus";
}

- (id)requestArgument {
    return @{
             @"state":@(_businessState),
             @"sessionKey":OBJC(self.sessionKey),
             };
}
@end
