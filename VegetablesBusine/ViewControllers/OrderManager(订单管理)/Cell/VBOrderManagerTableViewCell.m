//
//  VBOrderManagerTableViewCell.m
//  VegetablesBusine
//
//  Created by Apple on 2018/5/8.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "VBOrderManagerTableViewCell.h"
#import "VBCommodityListItemView.h"
#import "VBWaitDealListModel.h"

@implementation VBOrderManagerTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.mainContentView.layer.cornerRadius = 2.5;
    
    VBCommodityListItemView *commodityItemView = [[[NSBundle mainBundle] loadNibNamed:@"VBCommodityListItemView" owner:self options:nil] lastObject];
    commodityItemView.frame = CGRectMake(0, 0, SCREEN_WIDTH-20, 75);
    [self.commodityListView addSubview:commodityItemView];
}

- (void)setCellType:(VBOrderManagerTableViewStyle)cellType{
    _cellType = cellType;
    self.orderTotalAmountLabel.attributedText = [self setString:@"订单金额（已支付）" beginIndex:4 noHeightColor:[CommonTools changeColor:@"0x666666"]];
    if(_cellType == VBOrderManagerTableViewStyleloading){
        NSString *orderNumberTitle = [NSString stringWithFormat:@"#%@ 立即配送(待抢单)",self.itemModel.orderCount];
        NSMutableAttributedString *titleAttributedString = [self setString:orderNumberTitle beginIndex:[orderNumberTitle rangeOfString:@"立"].location noHeightColor:[CommonTools changeColor:@"0x666666"]];
        NSInteger locatin = [orderNumberTitle rangeOfString:@"("].location;
        [titleAttributedString setAttributes:@{NSForegroundColorAttributeName:[CommonTools changeColor:@"0xff9900"]} range:NSMakeRange(locatin, 5)];
        self.orderTitleLabel.attributedText = titleAttributedString;
    }else{
        NSString *orderNumberTitle = [NSString stringWithFormat:@"#%@ 立即配送(待抢单)",self.itemModel.orderCount];
        self.orderTitleLabel.attributedText = [self setString:orderNumberTitle beginIndex:self.itemModel.orderCount.length+2 noHeightColor:[CommonTools changeColor:@"0x666666"]];
    }
}
- (NSMutableAttributedString *)setString:(NSString *)textString beginIndex:(NSInteger)index noHeightColor:(UIColor *)color {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:textString];
    [attributedString setAttributes:@{NSForegroundColorAttributeName:color} range:NSMakeRange(0, index)];
    [attributedString setAttributes:@{NSForegroundColorAttributeName:[CommonTools changeColor:@"0x25ca86"]} range:NSMakeRange(index, textString.length-index)];
    return attributedString;
}
- (void)setItemModel:(VBWaitDealListModel *)itemModel {
    _itemModel = itemModel;
    [self.commodityListView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.commodityListViewHeight.constant = itemModel.listData.count*75;
    NSInteger index = 0;
    for(VBCommodityItemModel *commodityModel in itemModel.listData){
        VBCommodityListItemView *commodityItemView = [[[NSBundle mainBundle] loadNibNamed:@"VBCommodityListItemView" owner:self options:nil] lastObject];
        commodityItemView.frame = CGRectMake(0, index*75, SCREEN_WIDTH-20, 75);
        commodityItemView.commodityName.text = commodityModel.name;
        commodityItemView.priceLabel.text = [@"¥" stringByAppendingFormat:@"%@",commodityModel.unitPrice];
        commodityItemView.countLabel.text = [@"x" stringByAppendingFormat:@"%@",commodityModel.count];
        commodityItemView.totalPriceLabel.text = [@"¥" stringByAppendingFormat:@"%@",commodityModel.itemTotalPrice];
        [self.commodityListView addSubview:commodityItemView];
        index++;
    }
    self.orderTitleLabel.attributedText = [self setString:[NSString stringWithFormat:@"#%@ 立即配送",itemModel.orderCount] beginIndex:itemModel.orderCount.length+2 noHeightColor:[CommonTools changeColor:@"0x666666"]];
    self.orderOwnerLabel.text = itemModel.orderOwer;
    self.creatOrderLabel.text = [NSString stringWithFormat:@"#第%@次下单",itemModel.orderCount];
    self.telLabel.text = itemModel.orderTel;
    self.addressLabel.text = itemModel.orderDestination;
    self.totalPriceLabel.text = [NSString stringWithFormat:@"¥%@",itemModel.orderTotal];
    self.servicePriceLabel.text = [NSString stringWithFormat:@"¥%@",itemModel.serverPrice];
    self.orderTotalLabel.text = [NSString stringWithFormat:@"¥%@",itemModel.priceTotal];
    self.orderTotalProjectedRevenueLabel.text = [NSString stringWithFormat:@"¥%@",itemModel.orderExpectedIncome];
    if(itemModel.isCloselistData){
        [self.listCloseButton setImage:[UIImage imageNamed:@"pendingNewlaunchx_down"] forState:UIControlStateNormal];
    }else{
        [self.listCloseButton setImage:[UIImage imageNamed:@"pendingNewlaunchx"] forState:UIControlStateNormal];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
