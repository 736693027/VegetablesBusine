//
//  VBOrderDetailOrderStateTableViewCell.m
//  VegetablesBusine
//
//  Created by Apple on 2018/5/24.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "VBOrderDetailOrderStateTableViewCell.h"
#import "VBWaitDealListModel.h"

@interface VBOrderDetailOrderStateTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *orderNumeralLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderStateLabel;
@property (weak, nonatomic) IBOutlet UILabel *shipmentStateLabel;
@property (weak, nonatomic) IBOutlet UILabel *creatOrderLabel;

@end

@implementation VBOrderDetailOrderStateTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}
- (void)setItemModel:(VBWaitDealListModel *)itemModel {
    _itemModel = itemModel;
    self.orderNumeralLabel.text = [@"#" stringByAppendingFormat:@"%@",itemModel.orderNumeral];
    self.orderStateLabel.text = itemModel.orderState;
    self.shipmentStateLabel.text = itemModel.shipmentState;
    self.creatOrderLabel.text = itemModel.orderCreateTime;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
