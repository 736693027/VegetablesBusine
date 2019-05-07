//
//  VBSupportBookRequest.m
//  VegetablesBusine
//
//  Created by Apple on 2018/12/24.
//  Copyright © 2018 Apple. All rights reserved.
//

#import "VBSupportBookRequest.h"

@implementation VBSupportBookRequest{
    NSInteger _bookingState;
}

- (instancetype)initWithBookingState:(NSInteger)bookingState{
    self = [super init];
    if(self){
        _bookingState = bookingState;
    }
    return self;
}
- (NSString *)requestUrl {
    return @"/api/setting/bookingState";
}

- (id)requestArgument {
    return @{
             @"bookingState":@(_bookingState),
             @"sessionKey":OBJC(self.sessionKey),
             };
}
@end
