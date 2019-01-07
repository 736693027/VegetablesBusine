//
//  VBCommodityManagementTableViewCell.m
//  VegetablesBusine
//
//  Created by Apple on 2018/5/31.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "VBCommodityManagementTableViewCell.h"
#import "VBAlterView.h"
#import "VBCommodityManagementModel.h"
#import "VBCommoditySetupRequest.h"

@implementation VBCommodityManagementTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setItemModel:(VBCommodityManagementItemModel *)itemModel{
    _itemModel = itemModel;
    NSString *imgUrl = [NSString stringWithFormat:@"%@%@",BaseImageAddress,itemModel.commodityImgUrl];
    [self.commodityImagesView sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:PlaceHolderImage];
    self.commodityNameLabel.text = itemModel.commodityName;
    self.orderCount.text = itemModel.commoditySubtitle;
    self.priceLabel.text = [@"¥" stringByAppendingString:itemModel.commodityPrice];
}
- (IBAction)commodityShelvesAction:(UIButton *)sender {
    VBAlterView *alertView = [VBAlterView alterView];
    [alertView setTitle:@"您已确定下架此商品？" confirmButtonTitle:@"确定下架" cancleButtonTitle:@"取消"];
    @weakify(self)
    alertView.makeSureBlock = ^{
        VBCommoditySetupRequest *request = [[VBCommoditySetupRequest alloc] initWithCommodityId:self.itemModel.commodityId tab:@"1"];
        [request startRequestWithDicSuccess:^(NSDictionary *responseDic) {
            @strongify(self)
            if(self.uploadSubject){
                [self.uploadSubject sendNext:@""];
            }
            [SVProgressHUD showSuccessWithStatus:@"操作成功"];
        } failModel:^(LBResponseModel *errorModel) {
            [SVProgressHUD showErrorWithStatus:errorModel.message];
        } fail:^(YTKBaseRequest *request) {
            [SVProgressHUD showErrorWithStatus:@"下架失败"];
        }];
    };
    [alertView show];
}
- (IBAction)commodityDeleteAction:(UIButton *)sender {
    VBAlterView *alertView = [VBAlterView alterView];
    [alertView setTitle:@"您已确定删除此商品？" confirmButtonTitle:@"确定删除" cancleButtonTitle:@"取消"];
    @weakify(self)
    alertView.makeSureBlock = ^{
        VBCommoditySetupRequest *request = [[VBCommoditySetupRequest alloc] initWithCommodityId:self.itemModel.commodityId tab:@"2"];
        [request startRequestWithDicSuccess:^(NSDictionary *responseDic) {
            @strongify(self)
            if(self.uploadSubject){
                [self.uploadSubject sendNext:@""];
            }
            [SVProgressHUD showSuccessWithStatus:@"操作成功"];
        } failModel:^(LBResponseModel *errorModel) {
            [SVProgressHUD showErrorWithStatus:errorModel.message];
        } fail:^(YTKBaseRequest *request) {
            [SVProgressHUD showErrorWithStatus:@"删除失败"];
        }];
    };
    [alertView show];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
