//
//  VBWaitDealTableViewCell.m
//  VegetablesBusine
//
//  Created by Apple on 2018/5/8.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "VBWaitDealTableViewCell.h"
#import "VBCommodityListItemView.h"
#import "VBWaitDealListModel.h"
#import "VBProcessOrderRequest.h"

@implementation VBWaitDealTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.refusedButton.layer.cornerRadius = 2.5;
    self.refusedButton.layer.borderColor = [CommonTools changeColor:@"0xcccccc"].CGColor;
    self.refusedButton.layer.borderWidth = 0.5;
    self.orderButton.layer.cornerRadius = 2.5;
    self.mainContentView.layer.cornerRadius = 2.5;
    self.orderTotalAmountLabel.attributedText = [self setString:@"订单金额（已支付）" beginIndex:4 noHeightColor:[CommonTools changeColor:@"0x666666"]];
}

- (void)setItemModel:(VBWaitDealListModel *)itemModel {
    _itemModel = itemModel;
    [self.commodityListView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    if(!itemModel.isCloselistData){
        self.commodityListViewHeight.constant = itemModel.listData.count*75;
        for(VBCommodityItemModel *commodityModel in itemModel.listData){
            VBCommodityListItemView *commodityItemView = [[[NSBundle mainBundle] loadNibNamed:@"VBCommodityListItemView" owner:self options:nil] lastObject];
            commodityItemView.frame = CGRectMake(0, 0, SCREEN_WIDTH-20, 75);
            commodityItemView.commodityName.text = commodityModel.name;
            commodityItemView.priceLabel.text = [@"¥" stringByAppendingFormat:@"%@",commodityModel.unitPrice];
            commodityItemView.countLabel.text = [@"x" stringByAppendingFormat:@"%@",commodityModel.count];
            commodityItemView.totalPriceLabel.text = [@"¥" stringByAppendingFormat:@"%@",commodityModel.itemTotalPrice];
            [self.commodityListView addSubview:commodityItemView];
        }
    }else{
        self.commodityListViewHeight.constant = 0;
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

- (NSAttributedString *)setString:(NSString *)textString beginIndex:(NSInteger)index noHeightColor:(UIColor *)color {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:textString];
    [attributedString setAttributes:@{NSForegroundColorAttributeName:color} range:NSMakeRange(0, index)];
    [attributedString setAttributes:@{NSForegroundColorAttributeName:[CommonTools changeColor:@"0x25ca86"]} range:NSMakeRange(index, textString.length-index)];
    return attributedString;
}
- (IBAction)telButtonClick:(UIButton *)sender {
    NSString *telUrl = [NSString stringWithFormat:@"tel:%@",self.itemModel.orderTel];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:telUrl]];
}
- (IBAction)setListViewStateButtonClick:(UIButton *)sender {
//    [self.commodityListView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
//    if(!self.itemModel.isCloselistData){
//        self.commodityListViewHeight.constant = 0.f;
//        [sender setImage:[UIImage imageNamed:@"pendingNewlaunchx_down"] forState:UIControlStateNormal];
//    }else{
//        self.commodityListViewHeight.constant = self.itemModel.listData.count*75;
//        for(VBCommodityItemModel *commodityModel in self.itemModel.listData){
//            VBCommodityListItemView *commodityItemView = [[[NSBundle mainBundle] loadNibNamed:@"VBCommodityListItemView" owner:self options:nil] lastObject];
//            commodityItemView.frame = CGRectMake(0, 0, SCREEN_WIDTH-20, 75);
//            commodityItemView.commodityName.text = commodityModel.name;
//            commodityItemView.priceLabel.text = [@"¥" stringByAppendingFormat:@"%@",commodityModel.unitPrice];
//            commodityItemView.countLabel.text = [@"x" stringByAppendingFormat:@"%@",commodityModel.count];
//            commodityItemView.totalPriceLabel.text = [@"¥" stringByAppendingFormat:@"%@",commodityModel.itemTotalPrice];
//            [self.commodityListView addSubview:commodityItemView];
//        }
//        [sender setImage:[UIImage imageNamed:@"pendingNewlaunchx"] forState:UIControlStateNormal];
//    }
    self.itemModel.isCloselistData = !self.itemModel.isCloselistData;
    if(self.uploadCellState){
        [self.uploadCellState sendNext:@""];
    }
    
}
- (IBAction)receivedOrderButtonClick:(UIButton *)sender {
    [SVProgressHUD show];
    VBProcessOrderRequest *refundRequest = [[VBProcessOrderRequest alloc] initWithIdString:self.itemModel.orderId type:1];
    [refundRequest startRequestWithDicSuccess:^(NSDictionary *responseDic) {
        [SVProgressHUD dismiss];
        if(self.uploadDataSource){
            [self.uploadDataSource sendNext:@""];
        }
    } failModel:^(LBResponseModel *errorModel) {
        [SVProgressHUD showErrorWithStatus:errorModel.message];
    } fail:^(YTKBaseRequest *request) {
        [SVProgressHUD showErrorWithStatus:@"退款失败"];
    }];
}
- (IBAction)rejectOrderButtonCilck:(UIButton *)sender {
    [SVProgressHUD show];
    VBProcessOrderRequest *refundRequest = [[VBProcessOrderRequest alloc] initWithIdString:self.itemModel.orderId type:2];
    [refundRequest startRequestWithDicSuccess:^(NSDictionary *responseDic) {
        [SVProgressHUD dismiss];
        if(self.uploadDataSource){
            [self.uploadDataSource sendNext:@""];
        }
    } failModel:^(LBResponseModel *errorModel) {
        [SVProgressHUD showErrorWithStatus:errorModel.message];
    } fail:^(YTKBaseRequest *request) {
        [SVProgressHUD showErrorWithStatus:@"退款失败"];
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
