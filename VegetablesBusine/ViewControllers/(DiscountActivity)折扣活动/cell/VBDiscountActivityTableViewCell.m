//
//  VBDiscountActivityTableViewCell.m
//  VegetablesBusine
//
//  Created by 刘少轩 on 2018/7/1.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "VBDiscountActivityTableViewCell.h"

@implementation VBDiscountActivityTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.inputTextField.delegate = self;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if(self.inputResultSubject){
        [self.inputResultSubject sendNext:textField.text];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
