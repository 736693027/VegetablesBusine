//
//  VMLogoutRequestAPI.m
//  VegetableManagement
//
//  Created by Apple on 2018/7/8.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "VMLogoutRequestAPI.h"

@implementation VMLogoutRequestAPI


- (NSString *)requestUrl{
    return @"/api/user/logout";
}
- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}
- (id)requestArgument {
    return @{
             @"sessionKey":OBJC(self.sessionKey),
             };
}
@end
