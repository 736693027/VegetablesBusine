//
//  VBActivityRulesTableViewCell.m
//  VegetablesBusine
//
//  Created by 刘少轩 on 2018/6/30.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "VBActivityRulesTableViewCell.h"
#import <ReactiveObjC/ReactiveObjC.h>

@implementation VBActivityRulesTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}
- (IBAction)buttonClick:(UIButton *)sender {
    if(self.rulesSubject){
        [self.rulesSubject sendNext:@"+"];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
