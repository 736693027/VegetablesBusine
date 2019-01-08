//
//  VMGetBusinessStatisticsRequest.m
//  VegetablesBusine
//
//  Created by Apple on 2019/1/8.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "VMGetBusinessStatisticsRequest.h"

@implementation VMGetBusinessStatisticsRequest{
    NSInteger _type;
    NSString *_startTime;
    NSString *_endTime;
}

- (instancetype)initWithType:(NSInteger)type startTime:(NSString *)startTime endTime:(NSString *)endTime{
    self = [super init];
    if(self){
        _type = type;
        _startTime = startTime;
        _endTime = endTime;
    }
    return self;
}
- (NSString *)requestUrl {
    return @"/api/balance/store";
}
- (id)requestArgument {
    return @{
             @"sessionKey":OBJC(self.sessionKey),
             @"type":@(_type),
             @"startTime":OBJC(_startTime),
             @"endTime":OBJC(_endTime),
             };
}
@end
