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
@interface VBBusinessStateHeadView()
@property (weak, nonatomic) IBOutlet UIButton *statuButton1;
@property (weak, nonatomic) IBOutlet UIButton *statuButton2;
@property (weak, nonatomic) IBOutlet UIButton *bookingButton1;
@property (weak, nonatomic) IBOutlet UIButton *bookingButton2;
@end
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
        if (type == 0) {
            self.statuButton1.selected = NO;
            self.statuButton2.selected = YES;
        } else {
            self.statuButton1.selected = YES;
            self.statuButton2.selected = NO;
        }
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
        if (type == 0) {
            self.bookingButton1.selected = NO;
            self.bookingButton2.selected = YES;
        } else {
            self.bookingButton1.selected = YES;
            self.bookingButton2.selected = NO;
        }
    } failModel:^(LBResponseModel *errorModel) {
        [SVProgressHUD showErrorWithStatus:errorModel.message];
    } fail:^(YTKBaseRequest *request) {
        [SVProgressHUD showErrorWithStatus:@"设置失败"];

    }];
}


@end
