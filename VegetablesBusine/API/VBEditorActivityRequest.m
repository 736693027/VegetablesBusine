//
//  VBEditorActivityRequest.m
//  VegetablesBusine
//
//  Created by Apple on 2018/12/25.
//  Copyright © 2018 Apple. All rights reserved.
//

#import "VBEditorActivityRequest.h"

@implementation VBEditorActivityRequest
{
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
    return @"/api/active/activeEdit";
}

- (id)requestArgument {
    return @{
             @"activeId":OBJC(_activityId),
             @"sessionKey":OBJC(self.sessionKey),
             };
}
@end
