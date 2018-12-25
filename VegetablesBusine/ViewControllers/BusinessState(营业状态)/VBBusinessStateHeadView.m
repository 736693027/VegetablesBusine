//
//  VBBusinessStateHeadView.m
//  VegetablesBusine
//
//  Created by Apple on 2018/6/12.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "VBBusinessStateHeadView.h"
#import "VBSupportBookRequest.h"
#import "VBSetupBusinessStateRequest.h"

@implementation VBBusinessStateHeadView

- (IBAction)supportBookButtonClick:(id)sender {
    [self setSupportBookStateRequestWithType:1];
}
- (IBAction)noSupportBookButtonClick:(id)sender {
    [self setSupportBookStateRequestWithType:0];
}
- (IBAction)beginBusinessButtClick:(id)sender {
    [self setBusinessStateRequestWithType:1];
}
- (IBAction)stopBusinessClick:(id)sender {
    [self setBusinessStateRequestWithType:0];
}
- (void)setBusinessStateRequestWithType:(NSInteger)type{
    VBSetupBusinessStateRequest *setupBusinessStateRequest = [[VBSetupBusinessStateRequest alloc] initWithBusinessState:type];
    [SVProgressHUD show];
    [setupBusinessStateRequest startRequestWithDicSuccess:^(NSDictionary *responseDic) {
        [SVProgressHUD showInfoWithStatus:@"设置成功"];
    } failModel:^(LBResponseModel *errorModel) {
        [SVProgressHUD showErrorWithStatus:errorModel.message];
    } fail:^(YTKBaseRequest *request) {
        [SVProgressHUD showErrorWithStatus:@"设置失败"];
    }];
}
- (void)setSupportBookStateRequestWithType:(NSInteger)type{
    VBSupportBookRequest *supportRequest = [[VBSupportBookRequest alloc] initWithBookingState:type];
    [SVProgressHUD show];
    [supportRequest startRequestWithDicSuccess:^(NSDictionary *responseDic) {
        [SVProgressHUD showInfoWithStatus:@"设置成功"];
    } failModel:^(LBResponseModel *errorModel) {
        [SVProgressHUD showErrorWithStatus:errorModel.message];
    } fail:^(YTKBaseRequest *request) {
        [SVProgressHUD showErrorWithStatus:@"设置失败"];

    }];
}


@end
