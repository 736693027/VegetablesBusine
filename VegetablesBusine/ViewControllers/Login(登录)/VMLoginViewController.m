//
//  VMLoginViewController.m
//  VegetableManagement
//
//  Created by Apple on 2018/4/8.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "VMLoginViewController.h"
#import "VMLoginRequestAPI.h"
#import "VMRegisterViewController.h"
#import "VMForgetViewController.h"
#import "VMLoginUserInfoModel.h"

@interface VMLoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;

@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation VMLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}
- (IBAction)loginButtonClick:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];

    if(self.passwordTextField.text.length>0&&self.phoneNumberTextField.text.length>0){
        [SVProgressHUD showWithStatus:@"加载中..."];
        VMLoginRequestAPI *loginAPI = [[VMLoginRequestAPI alloc] initWithUsername:self.phoneNumberTextField.text password:self.passwordTextField.text];
        [loginAPI startRequestWithDicSuccess:^(NSDictionary *responseDic) {
            [SVProgressHUD showSuccessWithStatus:@"登录成功"];
            VMLoginUserInfoModel *loginModel = [VMLoginUserInfoModel loginUsrInfoModel];
            VMLoginUserInfoModel *tmpLoginModel = [VMLoginUserInfoModel yy_modelWithJSON:responseDic];
            loginModel = [tmpLoginModel copy];
            NSString *homePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) objectAtIndex:0];
            NSString *loginPath = [homePath stringByAppendingPathComponent:@"login.data"];
            BOOL result = [NSKeyedArchiver archiveRootObject:loginModel toFile:loginPath];
            if(!result){
                NSLog(@"------归档失败——---————-");
            }
            [self dismissViewControllerAnimated:YES completion:nil];
        } failModel:^(LBResponseModel *errorModel) {
            [SVProgressHUD showErrorWithStatus:errorModel.message];
        } fail:^(YTKBaseRequest *request) {
            
        }];
    }else if (self.passwordTextField.text.length>0){
        [SVProgressHUD showErrorWithStatus:@"请输入密码"];
    }else if (self.phoneNumberTextField.text.length>0){
        [SVProgressHUD showErrorWithStatus:@"请输入手机号"];
    }
}
- (IBAction)registerButtonClick:(id)sender {
//    VMRegisterViewController *registVC = [[VMRegisterViewController alloc] init];
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:registVC];
//    [self presentViewController:nav animated:YES completion:nil];
}
- (IBAction)forgetButtonClick:(id)sender {
    VMForgetViewController *forgerVC = [[VMForgetViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:forgerVC];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
