//
//  VBEditiActivityModel.h
//  VegetablesBusine
//
//  Created by Apple on 2018/12/26.
//  Copyright © 2018 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VBEditiActivityModel : NSObject

@property (copy, nonatomic) NSString *activeType;
@property (copy, nonatomic) NSString *startDateTime;
@property (copy, nonatomic) NSString *endDateTime;
@property (copy, nonatomic) NSString *days;
@property (copy, nonatomic) NSArray *ruler;//[{"10":"1"},{"20":"5"}]活动规则
@property (copy, nonatomic) NSString *amount;
@property (copy, nonatomic) NSString *gift;
@property (copy, nonatomic) NSString *discount;

@end

NS_ASSUME_NONNULL_END
