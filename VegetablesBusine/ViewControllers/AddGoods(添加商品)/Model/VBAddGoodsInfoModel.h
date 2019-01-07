//
//  VBAddGoodsInfoModel.h
//  VegetablesBusine
//
//  Created by Apple on 2018/12/13.
//  Copyright © 2018 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VBAddGoodsInfoModel : NSObject

@property (copy ,nonatomic) NSString *classify;
@property (copy ,nonatomic) NSString *classifyID;
@property (copy ,nonatomic) NSString *imageUrl;
@property (copy ,nonatomic) NSString *name;
@property (copy ,nonatomic) NSString *subtitle;
@property (copy, nonatomic) NSString *standardName;
@property (copy ,nonatomic) NSString *price;
@property (copy ,nonatomic) NSString *inventory;
@property (copy ,nonatomic) NSString *foodContainerPrice;
@property (copy ,nonatomic) NSString *unitName;
@property (copy ,nonatomic) NSString *uniti;
@property (copy ,nonatomic) NSString *commodityID;
@property (copy ,nonatomic) NSArray *standards;

@end

NS_ASSUME_NONNULL_END
