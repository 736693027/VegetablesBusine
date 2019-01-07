//
//  VMLoginUserInfoModel.m
//  VegetableManagement
//
//  Created by Apple on 2018/7/8.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "VMLoginUserInfoModel.h"
#import <objc/message.h>

@implementation VMLoginUserInfoModel

//+ (NSDictionary *)modelCustomPropertyMapper {
//    return @{@"lgoinUserId" : @"id"};
//}

+ (instancetype)loginUsrInfoModel{
    static dispatch_once_t onceToken;
    static VMLoginUserInfoModel *loginUserInfo;
    dispatch_once(&onceToken, ^{
        loginUserInfo = [[VMLoginUserInfoModel alloc] init];
    });
    return loginUserInfo;
}
- (void)clear{
    unsigned int propertyCount = 0;
    Ivar *ivas = class_copyIvarList([self class], &propertyCount);
    for(int i=0;i<propertyCount;i++){
        Ivar ivar = ivas[i];
        const char *name = ivar_getName(ivar);
        NSString *key = [NSString stringWithUTF8String:name];
        [self setValue:nil forKey:key];
    }
}
- (id)copyWithZone:(NSZone *)zone{
    VMLoginUserInfoModel *newModel = [VMLoginUserInfoModel loginUsrInfoModel];
    if(newModel){
        newModel.address = [self.address copyWithZone:zone];
        newModel.announcement = [self.announcement copyWithZone:zone];
        newModel.introduction = [self.introduction copyWithZone:zone];
        newModel.isAutomaticOrder = [self.isAutomaticOrder copyWithZone:zone];
        newModel.sessionKey = [self.sessionKey copyWithZone:zone];
        newModel.shopID = [self.shopID copyWithZone:zone];
        newModel.tel = [self.tel copyWithZone:zone];
        newModel.type = [self.type copyWithZone:zone];
    }
    return newModel;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if(self = [super init]){
        self.address = [aDecoder decodeObjectForKey:@"address"];
        self.announcement = [aDecoder decodeObjectForKey:@"announcement"];
        self.introduction = [aDecoder decodeObjectForKey:@"introduction"];
        self.isAutomaticOrder = [aDecoder decodeObjectForKey:@"isAutomaticOrder"];
        self.sessionKey = [aDecoder decodeObjectForKey:@"sessionKey"];
        self.shopID = [aDecoder decodeObjectForKey:@"shopID"];
        self.tel = [aDecoder decodeObjectForKey:@"tel"];
        self.type = [aDecoder decodeObjectForKey:@"type"];
    }
    return self;
}
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:_address forKey:@"address"];
    [aCoder encodeObject:_announcement forKey:@"announcement"];
    [aCoder encodeObject:_introduction forKey:@"introduction"];
    [aCoder encodeObject:_isAutomaticOrder forKey:@"isAutomaticOrder"];
    [aCoder encodeObject:_sessionKey forKey:@"sessionKey"];
    [aCoder encodeObject:_shopID forKey:@"shopID"];
    [aCoder encodeObject:_tel forKey:@"tel"];
    [aCoder encodeObject:_type forKey:@"type"];
}
@end
