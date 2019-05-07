//
//  VBActivieSelectWeekTableViewCell.m
//  VegetablesBusine
//
//  Created by 刘少轩 on 2018/6/30.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "VBActivieSelectWeekTableViewCell.h"

@implementation VBActivieSelectWeekTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)weekButtonClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    NSMutableArray *tagsArray = [NSMutableArray array];
    for(NSInteger tag = 100;tag<107;tag++){
        UIButton *weekButton = (UIButton *)[self.contentView viewWithTag:tag];
        if(weekButton.selected){
            [tagsArray addObject:@(tag-100+1)];
        }
    }
    if(self.selectWeekSubject){
        [self.selectWeekSubject sendNext:[tagsArray componentsJoinedByString:@","]];
    }
}
- (void)setSelectWeekResult:(NSString *)selectWeekResult{
    _selectWeekResult = selectWeekResult;
    NSArray *tagsArray = [selectWeekResult componentsSeparatedByString:@","];
    for(NSInteger tag = 0;tag<7;tag++){
        NSString *tagString = [NSString stringWithFormat:@"%ld",tag+1];
        if([tagsArray containsObject:tagString]){
            UIButton *weekButton = (UIButton *)[self.contentView viewWithTag:tag+100];
            weekButton.selected = YES;
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
