//
//  VBOrderDetailViewController.h
//  VegetablesBusine
//
//  Created by 刘少轩 on 2018/5/21.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "BaseTableViewController.h"

typedef NS_ENUM(NSInteger,VBOrderDetailType) {
    VBOrderDetailTypeNew = 1,//新订单
    VBOrderDetailTypeFinished, //已完成
};

@interface VBOrderDetailViewController : BaseTableViewController

@property (nonatomic) VBOrderDetailType orderType;

@end
