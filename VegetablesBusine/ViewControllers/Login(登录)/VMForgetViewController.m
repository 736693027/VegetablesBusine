//
//  VMForgetViewController.m
//  VegetableManagement
//
//  Created by Apple on 2018/7/10.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "VMForgetViewController.h"
#import "VMForgetPasswordAPI.h"

@interface VMForgetViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *againTextField;

@end

@implementation VMForgetViewController
- (void)navLeftButtonClicked:(UIButton *)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"重置密码";
}
- (IBAction)submitButtonClick:(id)sender {
    if(self.phoneNumberTextField.text.length == 0){
        [SVProgressHUD showErrorWithStatus:@"请输入手机号"];
        return;
    }else if(self.passwordTextField.text.length == 0){
        [SVProgressHUD showErrorWithStatus:@"请输入新证码"];
        return;
    }else if(self.againTextField.text.length == 0){
        [SVProgressHUD showErrorWithStatus:@"请再次输入新密码"];
        return;
    }else if (![self.passwordTextField.text isEqualToString:self.againTextField.text]){
        [SVProgressHUD showErrorWithStatus:@"俩次密码输入不一致，请重新输入"];
        return;
    }
    VMForgetPasswordAPI *forgetPasswordAPI = [[VMForgetPasswordAPI alloc] initWithPhoneNumber:self.phoneNumberTextField.text password:self.passwordTextField.text];
    [forgetPasswordAPI startRequestWithDicSuccess:^(NSDictionary *responseDic) {
        [SVProgressHUD showInfoWithStatus:@"修改成功，请重新登录"];
        [self dismissViewControllerAnimated:YES completion:nil];
    } failModel:^(LBResponseModel *errorModel) {
        [SVProgressHUD showErrorWithStatus:errorModel.message];
    } fail:^(YTKBaseRequest *request) {
        [SVProgressHUD showErrorWithStatus:@"修改失败"];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
