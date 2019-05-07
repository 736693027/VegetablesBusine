//
//  VMLoginUserInfoModel.h
//  VegetableManagement
//
//  Created by Apple on 2018/7/8.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VMLoginUserInfoModel : NSObject<NSCopying,NSCoding>

@property (copy, nonatomic) NSString *address;
@property (copy, nonatomic) NSString *announcement;
@property (copy, nonatomic) NSString *introduction;
@property (copy, nonatomic) NSString *isAutomaticOrder;
@property (copy, nonatomic) NSString *sessionKey;
@property (copy, nonatomic) NSString *shopID;
@property (copy, nonatomic) NSString *tel;
@property (copy, nonatomic) NSString *type; 

+ (instancetype)loginUsrInfoModel;

- (void)clear;

@end
