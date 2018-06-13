//
//  VBBusinessStateTableViewCell.m
//  VegetablesBusine
//
//  Created by Apple on 2018/6/12.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "VBBusinessStateTableViewCell.h"
#import <ReactiveObjC/ReactiveObjC.h>

@implementation VBBusinessStateTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    UITapGestureRecognizer *startTap = [[UITapGestureRecognizer alloc] init];
    self.startDateTimeView.userInteractionEnabled = YES;
    [self.startDateTimeView addGestureRecognizer:startTap];
    @weakify(self)
    [[startTap rac_gestureSignal] subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
        @strongify(self)
        if(self.selectStartDateTime){
            [self.selectStartDateTime sendNext:@""];
        }
    }];
    
    UITapGestureRecognizer *endTap = [[UITapGestureRecognizer alloc] init];
    self.endDateTimeView.userInteractionEnabled = YES;
    [self.endDateTimeView addGestureRecognizer:endTap];
    [[endTap rac_gestureSignal] subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
        @strongify(self)
        if(self.selectEndDateTime){
            [self.selectEndDateTime sendNext:@""];
        }
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
