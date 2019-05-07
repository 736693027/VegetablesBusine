//
//  VMForgetPasswordAPI.m
//  VegetableManagement
//
//  Created by Apple on 2018/8/14.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "VMForgetPasswordAPI.h"

@implementation VMForgetPasswordAPI{
    NSString *_phoneNumber;
    NSString *_password;
}
- (instancetype)initWithPhoneNumber:(NSString *)phoneNumber password:(NSString *)password{
    self = [super init];
    if(self){
        _phoneNumber = phoneNumber;
        _password = password;
    }
    return self;
}
- (NSString *)requestUrl{
    return @"/user/deliveryStaff/resertpwd";
}
- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}
- (id)requestArgument {
    return @{
             @"oncepwd":OBJC(_password),
             @"phone" : OBJC(_phoneNumber),
             @"twicepwd":OBJC(_phoneNumber)
             };
}
@end
