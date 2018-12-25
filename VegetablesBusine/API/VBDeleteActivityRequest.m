

//
//  VBDeleteActivityRequest.m
//  VegetablesBusine
//
//  Created by Apple on 2018/12/25.
//  Copyright © 2018 Apple. All rights reserved.
//

#import "VBDeleteActivityRequest.h"

@implementation VBDeleteActivityRequest{
    NSString *_activityId;
}
- (instancetype)initWithActivityId:(NSString *)activityId{
    self = [super init];
    if(self){
        _activityId = activityId;
    }
    return self;
}
- (NSString *)requestUrl {
    return @"/api/active/activeDel";
}

- (id)requestArgument {
    return @{
             @"activeId":OBJC(_activityId),
             @"sessionKey":OBJC(self.sessionKey),
             };
}
@end
