//
//  VBShopIntroductionViewController.m
//  VegetablesBusine
//
//  Created by Apple on 2018/6/10.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "VBShopIntroductionViewController.h"
#import "UITextView+Placeholder.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import "VBSetupStoreAddressRequest.h"

@interface VBShopIntroductionViewController ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *introductionTextView;

@end

@implementation VBShopIntroductionViewController

- (void)navRightButtonClicked:(UIButton *)sender{
    [self.introductionTextView endEditing:YES];
    if(self.introductionTextView.text.length == 0){
        [SVProgressHUD showErrorWithStatus:@"请输入相关内容"];
        return;
    }
    VBSetupStoreAddressRequest *request = [[VBSetupStoreAddressRequest alloc] initWithRemark:self.introductionTextView.text type:1];
    [request startRequestWithDicSuccess:^(NSDictionary *responseDic) {
        [SVProgressHUD showInfoWithStatus:@"保存成功"];
        [[NSNotificationCenter defaultCenter] postNotificationName:VBUploadStoreSetupInfoNotification object:nil];
        [self.navigationController popViewControllerAnimated:YES];
    } failModel:^(LBResponseModel *errorModel) {
        [SVProgressHUD showErrorWithStatus:errorModel.message];

    } fail:^(YTKBaseRequest *request) {
        [SVProgressHUD showErrorWithStatus:@"保存失败"];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    navRrightBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [navRrightBtn setTitle:@"保存" forState:UIControlStateNormal];
    [navRrightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    if(self.contentString.length>0){
        self.introductionTextView.text = self.contentString;
    }else{
        self.introductionTextView.placeholder = [NSString stringWithFormat:@"请输入%@信息...",self.title];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    if(self.textViewSubject){
        [self.textViewSubject sendNext:textView.text];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
