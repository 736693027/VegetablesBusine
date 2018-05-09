//
//  VBOrderManagerTableViewCell.m
//  VegetablesBusine
//
//  Created by Apple on 2018/5/8.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "VBOrderManagerTableViewCell.h"
#import "VBCommodityListItemView.h"

@implementation VBOrderManagerTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.refusedButton.layer.cornerRadius = 2.5;
    self.refusedButton.layer.borderColor = [CommonTools changeColor:@"0xcccccc"].CGColor;
    self.refusedButton.layer.borderWidth = 0.5;
    
    self.orderButton.layer.cornerRadius = 2.5;
    
    self.mainContentView.layer.cornerRadius = 2.5;
    
    VBCommodityListItemView *commodityItemView = [[[NSBundle mainBundle] loadNibNamed:@"VBCommodityListItemView" owner:self options:nil] lastObject];
    commodityItemView.frame = CGRectMake(0, 0, SCREEN_WIDTH-20, 75);
    [self.commodityListView addSubview:commodityItemView];
    self.orderTotalAmountLabel.attributedText = [self setString:@"订单金额（已支付）" beginIndex:4 noHeightColor:[CommonTools changeColor:@"0x666666"]];
    self.orderTitleLabel.attributedText = [self setString:@"#4 立即配送" beginIndex:3 noHeightColor:[CommonTools changeColor:@"0x666666"]];
    
}

- (NSAttributedString *)setString:(NSString *)textString beginIndex:(NSInteger)index noHeightColor:(UIColor *)color {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:textString];
    [attributedString setAttributes:@{NSForegroundColorAttributeName:color} range:NSMakeRange(0, index)];
    [attributedString setAttributes:@{NSForegroundColorAttributeName:[CommonTools changeColor:@"0x25ca86"]} range:NSMakeRange(index, textString.length-index)];
    return attributedString;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
