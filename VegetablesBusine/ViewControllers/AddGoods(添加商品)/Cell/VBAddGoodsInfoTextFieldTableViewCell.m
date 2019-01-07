//
//  VBAddGoodsInfoTextFieldTableViewCell.m
//  VegetablesBusine
//
//  Created by 刘少轩 on 2018/6/28.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "VBAddGoodsInfoTextFieldTableViewCell.h"

@implementation VBAddGoodsInfoTextFieldTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.infoTextField addTarget:self action:@selector(textFieldTextDidChange:) forControlEvents:UIControlEventEditingChanged];
}

- (void)textFieldTextDidChange:(UITextField *)textChange{
    if (self.inputBlock) {
        _inputBlock(textChange.text);
    }
}

@end
