//
//  VBNewManageCommodityClassificationTableViewCell.m
//  VegetablesBusine
//
//  Created by 刘少轩 on 2018/6/27.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "VBNewManageCommodityClassificationTableViewCell.h"
#import "VBManageCommodityClassificationModel.h"
#import "VBManageCommodityDeleteClassificationRequest.h"

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
    if(self.editingClassifySubject){
        [self.editingClassifySubject sendNext:@""];
    }
}
- (IBAction)deleteButtonClick:(id)sender {
    [SVProgressHUD show];
    VBManageCommodityDeleteClassificationRequest *deleteRequest = [[VBManageCommodityDeleteClassificationRequest alloc] initWithClassificationId:self.itemModel.classifyID];
    @weakify(self)
    [deleteRequest startRequestWithDicSuccess:^(NSDictionary *responseDic) {
        [SVProgressHUD dismiss];
        @strongify(self)
        if(self.deleteClassifySubject){
            [self.deleteClassifySubject sendNext:@""];
        }
        [SVProgressHUD showSuccessWithStatus:@"操作成功"];
    } failModel:^(LBResponseModel *errorModel) {
        [SVProgressHUD showErrorWithStatus:errorModel.message];
    } fail:^(YTKBaseRequest *request) {
        [SVProgressHUD showErrorWithStatus:@"删除失败"];
    }];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
