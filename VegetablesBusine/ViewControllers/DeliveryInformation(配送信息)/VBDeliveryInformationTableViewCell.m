//
//  VBDeliveryInformationTableViewCell.m
//  VegetablesBusine
//
//  Created by Apple on 2018/6/11.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "VBDeliveryInformationTableViewCell.h"
#import <ReactiveObjC/ReactiveObjC.h>

@implementation VBDeliveryInformationTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.textField.delegate = self;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if(self.textFieldSubject){
        [self.textFieldSubject sendNext:textField.text];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
