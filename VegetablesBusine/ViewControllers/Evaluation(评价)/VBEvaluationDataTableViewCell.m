//
//  VBEvaluationDataTableViewCell.m
//  VegetablesBusine
//
//  Created by 刘少轩 on 2018/6/24.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "VBEvaluationDataTableViewCell.h"
#import "XHStarRateView.h"
#import <Masonry/Masonry.h>
#import "UIView+YYAdd.h"

@implementation VBEvaluationDataTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    XHStarRateView *starRateView = [[XHStarRateView alloc] initWithFrame:CGRectMake(0, 0, 200, self.starRateView.height) numberOfStars:5 rateStyle:IncompleteStar isAnination:YES finish:^(CGFloat currentScore) {
        currentScore = 0.5;
    }];
    [self.starRateView addSubview:starRateView];
    [starRateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.left.offset(0);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
