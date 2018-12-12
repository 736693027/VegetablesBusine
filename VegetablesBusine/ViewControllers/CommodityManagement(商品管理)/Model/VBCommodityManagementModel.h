//
//  VBCommodityManagementModel.h
//  VegetablesBusine
//
//  Created by Apple on 2018/12/12.
//  Copyright © 2018 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VBCommodityManagementModel : NSObject

@property (copy, nonatomic) NSString *classificationId;
@property (copy, nonatomic) NSString *classificationName;
@property (copy, nonatomic) NSArray *commodityInfo;

@end

@interface VBCommodityManagementItemModel : NSObject

@property (copy, nonatomic) NSString *commodityId;
@property (copy, nonatomic) NSString *commodityName;
@property (copy, nonatomic) NSString *commoditySubtitle;
@property (copy, nonatomic) NSString *commodityPrice;
@property (copy, nonatomic) NSString *commodityImageUrl;

@end

NS_ASSUME_NONNULL_END
