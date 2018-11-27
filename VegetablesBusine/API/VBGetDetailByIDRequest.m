//
//  VBGetDetailByIDRequest.m
//  VegetablesBusine
//
//  Created by Apple on 2018/11/26.
//  Copyright © 2018 Apple. All rights reserved.
//

#import "VBGetDetailByIDRequest.h"

@implementation VBGetDetailByIDRequest{
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
    return @"/api/orders/getbyid";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    return @{
             @"id":OBJC(_idString),
             };
}
@end
