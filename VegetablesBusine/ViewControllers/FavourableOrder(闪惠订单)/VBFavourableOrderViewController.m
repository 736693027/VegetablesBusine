//
//  VBFavourableOrderViewController.m
//  VegetablesBusine
//
//  Created by 刘少轩 on 2018/6/24.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "VBFavourableOrderViewController.h"
#import "LBDatePickerView.h"
#import <ReactiveObjC/ReactiveObjC.h>

@interface VBFavourableOrderViewController ()

@end

@implementation VBFavourableOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"闪惠订单查询";
}
- (IBAction)selectDatetimeButtonClick:(UIButton *)sender {
    LBDatePickerView *lbDatePicker = [LBDatePickerView initPickView];
    lbDatePicker.resultSubject = [RACSubject subject];
    [lbDatePicker setDatePickModel:(UIDatePickerModeDate)];
    [lbDatePicker.resultSubject subscribeNext:^(NSDate * _Nullable date) {
        NSLog(@"-----%@",date);
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *dateTime = [dateFormatter stringFromDate:date];
        [sender setTitle:dateTime forState:UIControlStateNormal];
    }];
    [lbDatePicker showPickView];
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
