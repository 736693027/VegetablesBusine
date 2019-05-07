//
//  VBMerchantSettlementDataTableViewCell.m
//  VegetablesBusine
//
//  Created by 刘少轩 on 2018/6/27.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "VBMerchantSettlementDataTableViewCell.h"
@interface VBMerchantSettlementDataTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *titleName;
@property (weak, nonatomic) IBOutlet UILabel *statusString;
@property (weak, nonatomic) IBOutlet UILabel *priceString;
@property (weak, nonatomic) IBOutlet UILabel *balanceString;
@property (weak, nonatomic) IBOutlet UILabel *dataLable;
@end
@implementation VBMerchantSettlementDataTableViewCell

- (void)setItemModel:(MerchantSettlementListModel *)itemModel {
    _titleName.text = itemModel.title;
    NSString *status;
    if ([itemModel.state integerValue] == 1) {
        status = @"处理成功";
    } else {
        status = @"处理失败";
    }
    _statusString.text = status;
    _dataLable.text = itemModel.dataTime;
    _priceString.text = itemModel.amount;
    _balanceString.text = itemModel.balance;
}

@end
