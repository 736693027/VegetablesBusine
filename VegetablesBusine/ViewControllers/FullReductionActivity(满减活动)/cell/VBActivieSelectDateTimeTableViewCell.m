//
//  VBActivieSelectDateTimeTableViewCell.m
//  VegetablesBusine
//
//  Created by 刘少轩 on 2018/6/30.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "VBActivieSelectDateTimeTableViewCell.h"
#import "LBDatePickerView.h"
#import <ReactiveObjC/ReactiveObjC.h>

@implementation VBActivieSelectDateTimeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)startDateTimeButtonClick:(UIButton *)sender {
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
- (IBAction)endDateTimeButtonClick:(UIButton *)sender {
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

@end
