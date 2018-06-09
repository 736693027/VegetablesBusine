//
//  VBVBCommodityManagementTableViewCell.m
//  VegetablesBusine
//
//  Created by Apple on 2018/5/31.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "VBVBCommodityManagementTableViewCell.h"
#import "VBAlterView.h"

@implementation VBVBCommodityManagementTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)commodityShelvesAction:(UIButton *)sender {
    VBAlterView *alertView = [VBAlterView alterView];
    [alertView setTitle:@"您已确定下架此商品？" confirmButtonTitle:@"确定下架" cancleButtonTitle:@"取消"];
    [alertView show];
}
- (IBAction)commodityDeleteAction:(UIButton *)sender {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
