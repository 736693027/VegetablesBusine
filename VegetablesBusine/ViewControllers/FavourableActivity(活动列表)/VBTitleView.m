//
//  VBTitleView.m
//  VegetablesBusine
//
//  Created by Apple on 2018/6/26.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "VBTitleView.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import <Masonry/Masonry.h>

@interface VBTitleView()
@property (strong, nonatomic) UIButton *creatActivityButton;
@property (strong, nonatomic) UIButton *activityListButton;
@end

@implementation VBTitleView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        _creatActivityButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_creatActivityButton setTitle:@"创建活动" forState:UIControlStateNormal];
        [_creatActivityButton setTitleColor:[CommonTools changeColor:@"0x999999"] forState:UIControlStateNormal];
        [_creatActivityButton setTitleColor:[CommonTools changeColor:@"0x000000"] forState:UIControlStateSelected];
        _creatActivityButton.titleLabel.font = [UIFont systemFontOfSize:17];
        @weakify(self)
        [[_creatActivityButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            self.activityListButton.selected = NO;
            self.creatActivityButton.selected = YES;
             [self.selectIndexSubject sendNext:@0];
        }];
        _creatActivityButton.selected = YES;
        _creatActivityButton.frame = CGRectMake(0, 0, 80, frame.size.height);
        [self addSubview:_creatActivityButton];
        
        _activityListButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_activityListButton setTitle:@"活动列表" forState:UIControlStateNormal];
        [_activityListButton setTitleColor:[CommonTools changeColor:@"0x999999"] forState:UIControlStateNormal];
        [_activityListButton setTitleColor:[CommonTools changeColor:@"0x000000"] forState:UIControlStateSelected];
        _activityListButton.titleLabel.font = [UIFont systemFontOfSize:17];
        [[_activityListButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            self.activityListButton.selected = YES;
            self.creatActivityButton.selected = NO;
            if(self.selectIndexSubject){
                [self.selectIndexSubject sendNext:@1];
            }
        }];
        [self addSubview:_activityListButton];
        _activityListButton.frame = CGRectMake(frame.size.width-80, 0, 80, frame.size.height);
    }
    return self;
}

- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
}
@end
