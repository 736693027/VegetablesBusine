//
//  VBGoodsSpecificationsViewController.h
//  VegetablesBusine
//
//  Created by 刘少轩 on 2018/7/1.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "BaseViewController.h"

@interface VBGoodsSpecificationsViewController : BaseViewController
@property (nonatomic,strong)NSMutableArray *selectArray;
@property (nonatomic,copy)void(^callBackBlock)(NSArray *);
@end
