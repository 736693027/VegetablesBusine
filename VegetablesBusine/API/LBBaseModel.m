//
//  LBBaseModel.m
//  MBBase
//
//  Created by mobei on 15/12/3.
//  Copyright © 2015年 lubao. All rights reserved.
//

#import "LBBaseModel.h"

#define YYModelSynthCoderAndHash \
- (void)encodeWithCoder:(NSCoder *)aCoder { [self yy_modelEncodeWithCoder:aCoder]; } \
- (id)initWithCoder:(NSCoder *)aDecoder { return [self yy_modelInitWithCoder:aDecoder]; } \
- (id)copyWithZone:(NSZone *)zone { return [self yy_modelCopy]; } \
- (NSUInteger)hash { return [self yy_modelHash]; } \
- (BOOL)isEqual:(id)object { return [self yy_modelIsEqual:object]; }

@implementation LBBaseModel

YYModelSynthCoderAndHash

//+ (NSDictionary *)modelCustomPropertyMapper {
//    return @{@"result" : @[@"Result",@"result"],
//             @"message" : @[@"Message",@"message"],
//             @"data" : @[@"Data",@"data"]};
//}
//
//// 如果实现了该方法，则处理过程中不会处理该列表外的属性。
//+ (NSArray *)modelPropertyWhitelist {
//    return @[@"result",@"message"];
//}
//
//// 如果实现了该方法，则处理过程中会忽略该列表内的所有属性
//+ (NSArray *)modelPropertyBlacklist {
//    return @[@"data"];
//}

@end
