//
//  VBStoreTypeTableViewCell.m
//  VegetablesBusine
//
//  Created by 刘少轩 on 2018/6/24.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "VBStoreTypeTableViewCell.h"
#import "VBStoreTypeModel.h"

@implementation VBStoreTypeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(VBStoreTypeModel *)model{
    _model = model;
    self.typeNameLabel.text = model.typeName;
    if(model.isSelect){
        [self.stateImageView setImage:[UIImage imageNamed:@"checkbox1_checked"]];
    }else{
        [self.stateImageView setImage:[UIImage imageNamed:@"checkbox1_unchecked"]];
    }
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
