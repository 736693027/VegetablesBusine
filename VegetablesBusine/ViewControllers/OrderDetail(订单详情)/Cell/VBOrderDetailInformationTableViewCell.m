//
//  VBOrderDetailInformationTableViewCell.m
//  VegetablesBusine
//
//  Created by Apple on 2018/5/24.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "VBOrderDetailInformationTableViewCell.h"
#import "VBWaitDealListModel.h"

@interface VBOrderDetailInformationTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *orderNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *creatOrderLabel;
@property (weak, nonatomic) IBOutlet UILabel *remarkLabel;

@end

@implementation VBOrderDetailInformationTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setItemModel:(VBWaitDealListModel *)itemModel {
    _itemModel = itemModel;
    self.orderNumberLabel.text = itemModel.orderNumber;
    self.creatOrderLabel.text = itemModel.orderCreateTimeInfo;
    self.remarkLabel.text = itemModel.orderRemark;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
