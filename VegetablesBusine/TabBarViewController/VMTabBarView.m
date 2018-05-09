//
//  VMTabBarView.m
//  VegetableManagement
//
//  Created by Apple on 2018/4/4.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "VMTabBarView.h"
#import <Masonry/Masonry.h>

IB_DESIGNABLE
@implementation VMTabBarView

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self){
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.font = [UIFont systemFontOfSize:13];
        self.titleLabel.userInteractionEnabled = YES;
        [self addSubview:self.titleLabel];
        __weak typeof(self) weakSelf = self;
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(weakSelf);
            make.bottom.offset(-10);
        }];
        
        self.iconImageView = [[UIImageView alloc] init];
        self.iconImageView.userInteractionEnabled = YES;
        [self addSubview:self.iconImageView];
        
        [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(weakSelf);
            make.bottom.equalTo(weakSelf.titleLabel.mas_top).offset(-7.5);
        }];
    }
    return self;
}
- (void)setTitleLabel:(UILabel *)titleLabel{
    _titleLabel = titleLabel;
}
- (void)setIconImageView:(UIImageView *)iconImageView{
    _iconImageView = iconImageView;
}
- (void)awakeFromNib{
    [super awakeFromNib];    
}

@end
