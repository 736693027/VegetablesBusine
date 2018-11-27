//
//  VBWaitDealListModel.h
//  VBWaitDealListModel
//
//  Created by apple on 18/11/26.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "LBBaseModel.h"

@interface VBWaitDealListModel : LBBaseModel

@property (nonatomic, copy) NSString * actualAmount;
@property (nonatomic, copy) NSString * commission;
@property (nonatomic, copy) NSString * createdAt;
@property (nonatomic, copy) NSString * deliveryStaffId;
@property (nonatomic, copy) NSString * deliveryTime;
@property (nonatomic, copy) NSString * deliveryTimeStr;
@property (nonatomic, copy) NSString * estimatedAmount;
@property (nonatomic, copy) NSString * finishTime;
@property (nonatomic, copy) NSString * id;
@property (nonatomic, copy) NSString * ip;
@property (nonatomic, copy) NSString * note;
@property (nonatomic, copy) NSString * orderId;
@property (nonatomic, copy) NSString * orderStatus;
@property (nonatomic, copy) NSString * payStatus;
@property (nonatomic, copy) NSString * sendTime;
@property (nonatomic, copy) NSString * storeId;
@property (nonatomic, copy) NSString * updatedAt;
@property (nonatomic, copy) NSString * userId;
@property (nonatomic, copy) NSString * userLocationId;

@end
