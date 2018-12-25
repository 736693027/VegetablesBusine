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
    self.textField1.delegate = self;
    self.textField2.delegate = self;
}
- (void)setIndexPath:(NSIndexPath *)indexPath{
    _indexPath = indexPath;
    if(indexPath.row == 0){
        [self.editingButton setImage:[UIImage imageNamed:@"icon_addNewActive"] forState:UIControlStateNormal];
    }else{
        [self.editingButton setImage:[UIImage imageNamed:@"contractmanager_delete_contractNumber"] forState:UIControlStateNormal];
    }
}
- (IBAction)buttonClick:(UIButton *)sender {
    if(self.rulesSubject){
        [self.rulesSubject sendNext:self.indexPath];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if(self.textField1.text>0&&self.textField2.text>0){
        if(self.rulesDataSubject){
            NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:self.textField1.text,@"amount",self.textField2.text,@"text",nil];
            [self.rulesDataSubject sendNext:dict];
        }
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
