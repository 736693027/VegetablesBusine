//
//  VBAddGoodsViewController.h
//  VegetablesBusine
//
//  Created by 刘少轩 on 2018/6/28.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "BaseViewController.h"

@interface VBAddGoodsViewController : BaseViewController
@property (copy ,nonatomic) NSString *commodityID;
@property(nonatomic,copy)void(^freshBlock)(void);
@end

