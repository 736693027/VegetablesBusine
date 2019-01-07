//
//  MerchantSettlementListModel.h
//  VegetablesBusine
//
//  Created by ldv on 2019/1/6.
//  Copyright © 2019年 Apple. All rights reserved.
//
/*
 "idString": "1",
 "title": "用户下单",
 "state": "1",
 "dataTime": null,
 "amount": "123.00",
 "balance": "123.00",
 "serverPrice": "321.00",
 "incomeExpenditureStatus": "1"
 */
#import <Foundation/Foundation.h>

@interface MerchantSettlementListModel : NSObject
@property (copy ,nonatomic) NSString *idString;
@property (copy ,nonatomic) NSString *title;
@property (copy ,nonatomic) NSString *state;
@property (copy ,nonatomic) NSString *dataTime;
@property (copy ,nonatomic) NSString *amount;
@property (copy ,nonatomic) NSString *balance;
@property (copy ,nonatomic) NSString *serverPrice;
@property (copy ,nonatomic) NSString *incomeExpenditureStatus;
@end
