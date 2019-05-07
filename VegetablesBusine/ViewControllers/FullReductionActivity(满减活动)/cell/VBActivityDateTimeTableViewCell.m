//
//  VBActivityDateTimeTableViewCell.m
//  VegetablesBusine
//
//  Created by 刘少轩 on 2018/6/30.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "VBActivityDateTimeTableViewCell.h"
#import <ReactiveObjC/ReactiveObjC.h>

@implementation VBActivityDateTimeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)typeButtonClick:(UIButton *)sender {
    for(NSInteger i=100;i<103;i++){
        UIButton *button = (UIButton *)[self.contentView viewWithTag:i];
        if(button.tag != sender.tag){
            button.selected = NO;
        }
    }
    sender.selected = YES;
    NSNumber *index = [NSNumber numberWithInteger:sender.tag-100];
    if(self.activityTypeSubject){
        [self.activityTypeSubject sendNext:index];
    }
}
- (void)setSelectIndex:(NSInteger)selectIndex{
    UIButton *button = (UIButton *)[self.contentView viewWithTag:(selectIndex-1)+100];
    button.selected = YES;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
