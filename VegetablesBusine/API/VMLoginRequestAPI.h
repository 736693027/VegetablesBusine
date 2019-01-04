//
//  VMLoginRequestAPI.h
//  VegetableManagement
//
//  Created by Apple on 2018/7/8.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "LBBaseRequest.h"

@interface VMLoginRequestAPI : LBBaseRequest

- (instancetype)initWithUsername:(NSString *)username password:(NSString *)password;

@end
