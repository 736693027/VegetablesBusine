//
//  LBMoreCustomerNameCell.m
//  LBReport
//
//  Created by penzhk on 16/4/27.
//  Copyright © 2016年 FSLB. All rights reserved.
//

#import "LBMoreCustomerNameCell.h"

@implementation LBMoreCustomerNameCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    if(selected){
        [self.ImageView setImage:[UIImage imageNamed:@"btn_selected_pre"]];
    }else{
         [self.ImageView setImage:[UIImage imageNamed:@"btn_selected"]];
    }
    
    //[self.ImageView setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateNormal];
    
}

@end
