//
//  VBManageCommodityClassificationTableViewCell.m
//  VegetablesBusine
//
//  Created by 刘少轩 on 2018/6/27.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "VBManageCommodityClassificationTableViewCell.h"
#import "VBManageCommodityClassificationModel.h"

@interface VBManageCommodityClassificationTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *chooseIconImageView;

@end

@implementation VBManageCommodityClassificationTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setItemModel:(VBManageCommodityClassificationModel *)itemModel {
    _itemModel = itemModel;
    self.nameLabel.text = itemModel.classifyName;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
