//
//  VMOrderDetailTableViewCell.m
//  VegetableManagement
//
//  Created by Apple on 2018/4/12.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "VMOrderDetailTableViewCell.h"
#import "VBWaitDealListModel.h"

@interface VMOrderDetailTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *commodityNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *unitPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *commodityCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalPriceLabel;

@end

@implementation VMOrderDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setItemModel:(VBCommodityItemModel *)itemModel{
    _itemModel = itemModel;
    self.commodityNameLabel.text = itemModel.name;
    self.unitPriceLabel.text = [@"¥" stringByAppendingFormat:@"%@",itemModel.unitPrice];
    self.commodityCountLabel.text = [@"x" stringByAppendingFormat:@"%@",itemModel.count];
    self.totalPriceLabel.text = [@"¥" stringByAppendingFormat:@"%@",itemModel.itemTotalPrice];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
