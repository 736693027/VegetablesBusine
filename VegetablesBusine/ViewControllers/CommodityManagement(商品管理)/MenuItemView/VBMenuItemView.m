//
//  VBMenuItemView.m
//  VegetablesBusine
//
//  Created by Apple on 2018/5/31.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "VBMenuItemView.h"
#import <Masonry/Masonry.h>
#import <ReactiveObjC/ReactiveObjC.h>

@implementation VBMenuItemView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [CommonTools changeColor:@"0x000000"];
        _titleLabel.font = [UIFont systemFontOfSize:13];
        _titleLabel.numberOfLines = 0;
        [self addSubview:_titleLabel];
        @weakify(self)
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self)
            make.left.offset(10);
            make.right.offset(-10);
            make.centerY.mas_equalTo(self);
        }];
        
        UIView *bottomLine = [[UIView alloc] init];
        bottomLine.backgroundColor  = [CommonTools changeColor:@"0xcccccc"];
        [self addSubview:bottomLine];
        [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.offset(0);
            make.height.offset(0.5);
        }];
    }
    return self;
}

- (void)setControlState:(UIControlState)controlState{
    _controlState = controlState;
    switch (controlState) {
        case UIControlStateNormal:
        {
            self.backgroundColor = [CommonTools changeColor:@"0xefefef"];
            self.titleLabel.textColor = [CommonTools changeColor:@"0x666666"];
        }
            break;
        case UIControlStateSelected:
        {
            self.backgroundColor = [CommonTools changeColor:@"0xffffff"];
            self.titleLabel.textColor = [CommonTools changeColor:@"0x000000"];
        }
            break;
            
        default:
            break;
    }
}

@end
