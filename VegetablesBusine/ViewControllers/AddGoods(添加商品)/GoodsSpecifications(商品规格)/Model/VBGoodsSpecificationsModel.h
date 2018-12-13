//
//  VBGoodsSpecificationsModel.h
//  VegetablesBusine
//
//  Created by Apple on 2018/12/12.
//  Copyright © 2018 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VBGoodsSpecificationsModel : NSObject

@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSArray *standardsInfo;

@end

@interface VBGoodsSpecificationsItemModel : NSObject

@property (copy, nonatomic) NSString *standardsName; //规格名称 
@property (copy, nonatomic) NSString *standardsID;
@property (copy, nonatomic) NSString *inventory; //库存
@property (copy, nonatomic) NSString *price; //价格

@end

NS_ASSUME_NONNULL_END
