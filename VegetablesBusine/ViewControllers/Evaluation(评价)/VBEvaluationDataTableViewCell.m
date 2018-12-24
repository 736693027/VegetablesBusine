//
//  VBEvaluationDataTableViewCell.m
//  VegetablesBusine
//
//  Created by 刘少轩 on 2018/6/24.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "VBEvaluationDataTableViewCell.h"
#import "XHStarRateView.h"
#import <Masonry/Masonry.h>
#import "UIView+YYAdd.h"
#import "VBEvaluationDataModel.h"
#import "VBEvaluationReplyRequestAPI.h"

@interface VBEvaluationDataTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *senderNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *commodityNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (strong, nonatomic) XHStarRateView *starRateInfoView;

@end

@implementation VBEvaluationDataTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.starRateInfoView = [[XHStarRateView alloc] initWithFrame:CGRectMake(0, 0, 200, self.starRateView.height) numberOfStars:5 rateStyle:IncompleteStar isAnination:YES finish:^(CGFloat currentScore) {
        currentScore = 0.5;
    }];
    [self.starRateView addSubview:self.starRateInfoView];
    [self.starRateInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.left.offset(0);
    }];
}
- (void)setItemModel:(VBEvaluationDataModel *)itemModel{
    _itemModel = itemModel;
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:itemModel.imageUrl] placeholderImage:PlaceHolderImage];
    self.senderNameLabel.text = itemModel.name;
    self.dateTimeLabel.text = itemModel.dataTime;
    self.commodityNameLabel.text = [NSString stringWithFormat:@"商品：%@",itemModel.commodityName];
    self.contentLabel.text = itemModel.content;
    self.starRateInfoView.progress = itemModel.star.integerValue;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)replyButtonClick:(UIButton *)sender {
    NSString *title = [NSString stringWithFormat:@"回复：%@",self.itemModel.name];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:@"请输入回复内容" preferredStyle:(UIAlertControllerStyleAlert)];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        
    }];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"提交" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        UITextField *envirnmentNameTextField = alertController.textFields.firstObject;
        NSLog(@"----------%@",envirnmentNameTextField.text);
        if(envirnmentNameTextField.text.length == 0){
            [SVProgressHUD showErrorWithStatus:@"请输入回复内容"];
            return ;
        }
        [SVProgressHUD show];
        VBEvaluationReplyRequestAPI *request = [[VBEvaluationReplyRequestAPI alloc] initWithCommentId:self.itemModel.commentId content:envirnmentNameTextField.text];
        @weakify(self)
        [request startRequestWithDicSuccess:^(NSDictionary *responseDic) {
            [SVProgressHUD showInfoWithStatus:@"提交成功"];
            @strongify(self)
            if(self.replySuccessSubject){
                [self.replySuccessSubject sendNext:@""];
            }
        } failModel:^(LBResponseModel *errorModel) {
             [SVProgressHUD showErrorWithStatus:errorModel.message];
        } fail:^(YTKBaseRequest *request) {
             [SVProgressHUD showErrorWithStatus:@"提交失败"];
        }];
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self.viewController presentViewController:alertController animated:YES completion:^{
        
    }];
}

@end
