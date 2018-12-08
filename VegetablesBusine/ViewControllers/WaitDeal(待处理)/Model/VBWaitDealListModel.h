//
//  VBWaitDealListModel.h
//  VBWaitDealListModel
//
//  Created by apple on 18/11/26.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "LBBaseModel.h"

@interface VBWaitDealListModel : LBBaseModel

@property (nonatomic, copy) NSString * orderId; //订单Id
@property (nonatomic, copy) NSString * Longitude; //经度
@property (nonatomic, copy) NSString * latitude; //纬度
@property (nonatomic, copy) NSString * orderNumeral; //订单排号
@property (nonatomic, copy) NSString * orderNumber; //订单编号
@property (nonatomic, copy) NSString * orderCreateTime; //下单时间
@property (nonatomic, copy) NSString * orderCreateTimeInfo; //下单时间
@property (nonatomic, copy) NSString * orderState; //下单时间
@property (nonatomic, copy) NSString * orderOwer; //订单归属人
@property (nonatomic, copy) NSString * orderCount; //第几次下单
@property (nonatomic, copy) NSString * orderTel; //联系电话
@property (nonatomic, copy) NSString * address; //配送地址
@property (nonatomic, copy) NSString * orderRemark; //订单备注
@property (nonatomic, copy) NSString * orderPaymentState; //订单支付状态
@property (nonatomic, copy) NSString * shipmentState; //配送状态
@property (nonatomic, copy) NSString * orderTotal; //订单总额
@property (nonatomic, copy) NSString * serverPrice; //服务费
@property (nonatomic, copy) NSString * priceTotal; //合计
@property (nonatomic, copy) NSString * orderExpectedIncome; //订单预计收入
@property (nonatomic, copy) NSArray * listData; //购买商品明细
@property (nonatomic, assign) BOOL isCloselistData; //购买商品明细

@end

@interface VBCommodityItemModel : LBBaseModel

@property (nonatomic, copy) NSString * name; //商品名称
@property (nonatomic, copy) NSString * unitPrice; //单价
@property (nonatomic, copy) NSString * count; //购买数量
@property (nonatomic, copy) NSString * itemTotalPrice; //总价

@end
