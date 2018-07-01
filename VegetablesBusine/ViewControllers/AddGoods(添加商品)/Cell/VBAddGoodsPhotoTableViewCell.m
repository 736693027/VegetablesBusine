//
//  VBAddGoodsPhotoTableViewCell.m
//  VegetablesBusine
//
//  Created by 刘少轩 on 2018/6/28.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "VBAddGoodsPhotoTableViewCell.h"

@implementation VBAddGoodsPhotoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.nameTextField addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
}
- (void)textFieldDidChanged:(UITextField *)textField{
    NSString *textString = textField.text;
    if(textString.length>10){
        textString = [textString substringToIndex:10];
    }
    textField.text = textString;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
