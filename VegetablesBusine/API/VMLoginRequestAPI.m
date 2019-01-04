//
//  VMLoginRequestAPI.m
//  VegetableManagement
//
//  Created by Apple on 2018/7/8.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "VMLoginRequestAPI.h"

@implementation VMLoginRequestAPI{
    NSString *_username;
    NSString *_password;
}

- (instancetype)initWithUsername:(NSString *)username password:(NSString *)password{
    self = [super init];
    if(self){
        _username = username;
        _password = password;
    }
    return self;
}
- (NSString *)requestUrl{
    return @"/api/user/login";
}
- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}
- (id)requestArgument {
    return @{
             @"username":OBJC(_username),
             @"password" : OBJC(_password)
             };
}
@end
