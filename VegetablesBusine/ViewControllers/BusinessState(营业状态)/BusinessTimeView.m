//
//  BusinessTimeView.m
//  VegetablesBusine
//
//  Created by Apple on 2018/6/21.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "BusinessTimeView.h"
#import <ReactiveObjC/ReactiveObjC.h>

@implementation BusinessTimeView

- (void)awakeFromNib{
    [super awakeFromNib];
    self.selectState = YES;
    self.timeLabel.userInteractionEnabled = YES;
    self.iconImage.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    @weakify(self)
    [[tap rac_gestureSignal] subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
        @strongify(self)
        self.selectState = !self.selectState;
        if(self.gestureSubject){
            [self.gestureSubject sendNext:self];
        }
    }];
    [self addGestureRecognizer:tap];
}

- (void)setSelectState:(BOOL)selectState{
    _selectState = selectState;
    if(selectState){
        self.iconImage.hidden = NO;
        self.layer.borderWidth = 0.5;
        self.layer.borderColor = [CommonTools changeColor:@"0x01cd88"].CGColor;
    }else{
        self.iconImage.hidden = YES;
        self.layer.borderWidth = 0.5;
        self.layer.borderColor = [CommonTools changeColor:@"0xffffff"].CGColor;
    }
}

@end
