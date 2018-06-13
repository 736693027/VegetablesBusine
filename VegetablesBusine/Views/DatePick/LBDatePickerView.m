//
//  LBDatePickerView.m
//  LBAssistant
//
//  Created by Apple on 2018/5/16.
//  Copyright © 2018年 FSLB. All rights reserved.
//

#import "LBDatePickerView.h"
#import <ReactiveObjC/ReactiveObjC.h>

@interface LBDatePickerView()
@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UIDatePicker *pickerView;
@end

@implementation LBDatePickerView

LBDatePickerView *lbDatePickerView;

+ (instancetype)initPickView{
    lbDatePickerView = [[[NSBundle mainBundle] loadNibNamed:@"LBDatePickerView" owner:self options:nil] lastObject];
    [lbDatePickerView.pickerView setCalendar:[NSCalendar currentCalendar]];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    __weak typeof(lbDatePickerView) weakPickView = lbDatePickerView;
    [[tap rac_gestureSignal] subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
        [weakPickView hiddenPickView];
    }];
    lbDatePickerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [lbDatePickerView addGestureRecognizer:tap];
    return lbDatePickerView;
}

- (IBAction)cancelButtonClick:(UIButton *)sender {
    [self hiddenPickView];
}
- (IBAction)confirmButtonClick:(UIButton *)sender {
    if(self.resultSubject){
        [self.resultSubject sendNext:self.pickerView.date];
    }
    [self hiddenPickView];
}
- (void)showPickView{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:lbDatePickerView];
    CGRect frame = self.mainView.frame;
    frame.origin.y = SCREEN_HEIGHT;
    self.mainView.frame = frame;
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = self.mainView.frame;
        frame.origin.y = SCREEN_HEIGHT-200;
        self.mainView.frame = frame;
    }];
}
- (void)hiddenPickView{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = self.mainView.frame;
        frame.origin.y = SCREEN_HEIGHT;
        self.mainView.frame = frame;
    } completion:^(BOOL finished) {
        [lbDatePickerView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [lbDatePickerView removeFromSuperview];
        lbDatePickerView = nil;
    }];
}
@end
