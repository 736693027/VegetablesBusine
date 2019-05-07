//
//  VBOrderDetailViewController.h
//  VegetablesBusine
//
//  Created by 刘少轩 on 2018/5/21.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "BaseTableViewController.h"
@class RACSubject;

typedef NS_ENUM(NSInteger,VBOrderDetailType) {
    VBOrderDetailTypeNewOrder = 1,//新订单
    VBOrderDetailTypeRefund, //退款
    VBOrderDetailTypeOrderManager, //订单管理
};

@interface VBOrderDetailViewController : BaseTableViewController

@property (nonatomic) VBOrderDetailType orderType;

@property (copy, nonatomic) NSString *orderIdString;

@property (strong, nonatomic) RACSubject *uploadDataSource;

@end
