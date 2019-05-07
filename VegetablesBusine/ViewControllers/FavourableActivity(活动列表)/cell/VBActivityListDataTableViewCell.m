//
//  VBActivityListDataTableViewCell.m
//  VegetablesBusine
//
//  Created by 刘少轩 on 2018/6/26.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "VBActivityListDataTableViewCell.h"
#import "VBActivityListModel.h"
#import "VBDeleteActivityRequest.h"

@implementation VBActivityListDataTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)deleteActivityButtonClick:(UIButton *)sender {
    [SVProgressHUD show];
    @weakify(self)
    VBDeleteActivityRequest *deleteRequest = [[VBDeleteActivityRequest alloc] initWithActivityId:self.itemModel.activeId];
    [deleteRequest startRequestWithDicSuccess:^(NSDictionary *responseDic) {
        @strongify(self)
        [SVProgressHUD showInfoWithStatus:@"删除成功"];
        if(self.deleteSuccessSubject){
            [self.deleteSuccessSubject sendNext:@""];
        }
    } failModel:^(LBResponseModel *errorModel) {
        [SVProgressHUD showErrorWithStatus:errorModel.message];
    } fail:^(YTKBaseRequest *request) {
        [SVProgressHUD showErrorWithStatus:@"删除失败"];
    }];
}

- (void)setItemModel:(VBActivityListModel *)itemModel{
    _itemModel = itemModel;
    self.activityTypeLabel.text = itemModel.title;
    self.activityRuleLabel.text = [NSString stringWithFormat:@"活动规则：%@",itemModel.activeRuler];
    self.activityDateTime.text = [NSString stringWithFormat:@"活动时间：%@",itemModel.activeDateTime];
    self.activityStateLabel.text = [NSString stringWithFormat:@"活动状态：%@",itemModel.activeState];
    self.activityCreatDateTimeLabel.text = [NSString stringWithFormat:@"创建时间：%@",itemModel.activeCreateTime];

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
