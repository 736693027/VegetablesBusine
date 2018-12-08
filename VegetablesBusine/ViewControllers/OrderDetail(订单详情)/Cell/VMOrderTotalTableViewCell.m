//
//  VMOrderTotalTableViewCell.m
//  VegetableManagement
//
//  Created by Apple on 2018/4/12.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "VMOrderTotalTableViewCell.h"
#import "VBWaitDealListModel.h"

@interface VMOrderTotalTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *orderTotalPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *servicePriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderExpectedIncomeLabel;

@end

@implementation VMOrderTotalTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setItemModel:(VBWaitDealListModel *)itemModel {
    _itemModel = itemModel;
    self.orderTotalPriceLabel.text = [NSString stringWithFormat:@"¥%@",itemModel.orderTotal];
    self.servicePriceLabel.text = [NSString stringWithFormat:@"¥%@",itemModel.serverPrice];
    self.totalPriceLabel.text = [NSString stringWithFormat:@"¥%@",itemModel.priceTotal];
    self.orderExpectedIncomeLabel.text = [NSString stringWithFormat:@"¥%@",itemModel.orderExpectedIncome];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
