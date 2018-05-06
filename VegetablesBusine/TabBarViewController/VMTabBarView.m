//
//  VMTabBarView.m
//  VegetableManagement
//
//  Created by Apple on 2018/4/4.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "VMTabBarView.h"
#import <Masonry/Masonry.h>

@implementation VMTabBarView
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self){
        self.iconImageView = [[UIImageView alloc] init];
        [self addSubview:self.iconImageView];
        [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(10);
            make.centerX.mas_equalTo(self);
        }];
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.font = [UIFont systemFontOfSize:13];
        [self addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.iconImageView.mas_bottom).offset(5);
            make.centerX.mas_equalTo(self);
        }];
    }
    return self;
}
- (void)awakeFromNib{
    [super awakeFromNib];    
}

@end
