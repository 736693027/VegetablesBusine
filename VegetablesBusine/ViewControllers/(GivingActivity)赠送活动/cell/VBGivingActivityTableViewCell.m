//
//  VBGivingActivityTableViewCell.m
//  VegetablesBusine
//
//  Created by 刘少轩 on 2018/7/1.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "VBGivingActivityTableViewCell.h"

@implementation VBGivingActivityTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.textField addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
}

- (void)textFieldDidChanged:(UITextField *)textField{
    NSString *text = textField.text;
    if(text.length>10){
        text = [text substringToIndex:10];
    }
    textField.text = text;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
