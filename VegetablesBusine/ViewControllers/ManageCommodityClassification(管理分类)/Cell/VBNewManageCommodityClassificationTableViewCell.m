//
//  VBNewManageCommodityClassificationTableViewCell.m
//  VegetablesBusine
//
//  Created by 刘少轩 on 2018/6/27.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "VBNewManageCommodityClassificationTableViewCell.h"
#import "VBManageCommodityClassificationModel.h"

@interface VBNewManageCommodityClassificationTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *commodityNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *commodityCountLabel;

@end

@implementation VBNewManageCommodityClassificationTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setItemModel:(VBManageCommodityClassificationModel *)itemModel{
    _itemModel = itemModel;
    self.commodityNameLabel.text = itemModel.classifyName;
    self.commodityCountLabel.text = [NSString stringWithFormat:@"%@件商品",itemModel.classifyTotalCount];
}
- (IBAction)editingButtonClick:(id)sender {
}
- (IBAction)deleteButtonClick:(id)sender {
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
