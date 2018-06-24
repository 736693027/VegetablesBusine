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

@interface VBBusinessStatisticsDataCustomViewController ()

@end

@implementation VBBusinessStatisticsDataCustomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (IBAction)selectDateTimeButtonClick:(UIButton *)sender {
    VBCalendarViewController *calendarVC = [[VBCalendarViewController alloc] init];
    calendarVC.dateSubject = [RACSubject subject];
    [calendarVC.dateSubject subscribeNext:^(NSDate  *_Nullable date) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *dateTime = [dateFormatter stringFromDate:date];
        [sender setTitle:dateTime forState:UIControlStateNormal];
    }];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:calendarVC];
    [self presentViewController:nav animated:YES completion:nil];
}
- (IBAction)searchButtonClick:(UIButton *)sender {
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
