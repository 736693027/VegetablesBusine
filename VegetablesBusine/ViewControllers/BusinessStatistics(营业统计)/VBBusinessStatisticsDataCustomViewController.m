//
//  VBBusinessStatisticsDataCustomViewController.m
//  VegetablesBusine
//
//  Created by 刘少轩 on 2018/6/24.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "VBBusinessStatisticsDataCustomViewController.h"
#import "VBCalendarViewController.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import "VMGetBusinessStatisticsRequest.h"

@interface VBBusinessStatisticsDataCustomViewController ()
@property (weak, nonatomic) IBOutlet UILabel *totalTurnoverLabel;
@property (weak, nonatomic) IBOutlet UILabel *merchantSubsidyLabel;
@property (weak, nonatomic) IBOutlet UILabel *effectiveOrderLabel;
@property (weak, nonatomic) IBOutlet UILabel *invalidOrderLabel;
@property (weak, nonatomic) IBOutlet UIButton *startTimeButton;
@property (weak, nonatomic) IBOutlet UIButton *endTimeButton;
@property (copy, nonatomic) NSString *startTime;
@property (copy, nonatomic) NSString *endTime;
@end

@implementation VBBusinessStatisticsDataCustomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateTime = [dateFormatter stringFromDate:[NSDate date]];
    [self.startTimeButton setTitle:dateTime forState:UIControlStateNormal];
    [self.endTimeButton setTitle:dateTime forState:UIControlStateNormal];
    self.startTime = dateTime;
    self.endTime = dateTime;

    [SVProgressHUD show];
    VMGetBusinessStatisticsRequest *request = [[VMGetBusinessStatisticsRequest alloc] initWithType:4 startTime:self.startTime endTime:self.endTime];
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
- (IBAction)selectDateTimeButtonClick:(UIButton *)sender {
    VBCalendarViewController *calendarVC = [[VBCalendarViewController alloc] init];
    calendarVC.dateSubject = [RACSubject subject];
    [calendarVC.dateSubject subscribeNext:^(NSDate  *_Nullable date) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *dateTime = [dateFormatter stringFromDate:date];
        [sender setTitle:dateTime forState:UIControlStateNormal];
        if(sender.tag == 100){
            self.startTime = dateTime;
        }else{
            self.endTime = dateTime;
        }
    }];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:calendarVC];
    [self presentViewController:nav animated:YES completion:nil];
}
- (IBAction)searchButtonClick:(UIButton *)sender {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *startDateTime = [dateFormatter dateFromString:self.startTime];
    NSDate *endDateTime = [dateFormatter dateFromString:self.endTime];
    NSComparisonResult result = [endDateTime compare:startDateTime];
    if(result == NSOrderedDescending){
        [SVProgressHUD show];
        VMGetBusinessStatisticsRequest *request = [[VMGetBusinessStatisticsRequest alloc] initWithType:4 startTime:self.startTime endTime:self.endTime];
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
    }else{
        [SVProgressHUD showErrorWithStatus:@"起始时间必须大于截止时间"];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
