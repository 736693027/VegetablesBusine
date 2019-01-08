//
//  VBBusinessStatisticsDataNormalViewController.m
//  VegetablesBusine
//
//  Created by 刘少轩 on 2018/6/24.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "VBBusinessStatisticsDataNormalViewController.h"
#import "VMGetBusinessStatisticsRequest.h"


@interface VBBusinessStatisticsDataNormalViewController ()
@property (weak, nonatomic) IBOutlet UILabel *totalTurnoverLabel;
@property (weak, nonatomic) IBOutlet UILabel *merchantSubsidyLabel;
@property (weak, nonatomic) IBOutlet UILabel *effectiveOrderLabel;
@property (weak, nonatomic) IBOutlet UILabel *invalidOrderLabel;

@end

@implementation VBBusinessStatisticsDataNormalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [SVProgressHUD show];
    VMGetBusinessStatisticsRequest *request = [[VMGetBusinessStatisticsRequest alloc] initWithType:self.type startTime:@"" endTime:@""];
    [request startRequestWithDicSuccess:^(NSDictionary *responseDic) {
        [SVProgressHUD dismiss];
        self.totalTurnoverLabel.text = [NSString stringWithFormat:@"¥%@",[responseDic objectForKey:@"totalTurnover"]];
        self.merchantSubsidyLabel.text = [NSString stringWithFormat:@"¥%@",[responseDic objectForKey:@"merchantSubsidy"]];
        self.effectiveOrderLabel.text = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"effectiveOrder"]];
        self.invalidOrderLabel.text = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"invalidOrder"]];
    } failModel:^(LBResponseModel *errorModel) {
        [SVProgressHUD showErrorWithStatus:errorModel.message];
    } fail:^(YTKBaseRequest *request) {
        [SVProgressHUD showErrorWithStatus:@"获取失败"];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
