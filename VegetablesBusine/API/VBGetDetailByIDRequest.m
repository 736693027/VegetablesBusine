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
    return [NSString stringWithFormat:@"/api/order/getOrder/%@",_idString];
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}

- (id)requestArgument {
    return @{};
}
@end
