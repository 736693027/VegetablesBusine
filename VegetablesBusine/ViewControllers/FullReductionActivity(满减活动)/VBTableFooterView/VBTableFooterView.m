//
//  VBTableFooterView.m
//  VegetablesBusine
//
//  Created by 刘少轩 on 2018/6/30.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "VBTableFooterView.h"

@implementation VBTableFooterView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)btnClickAction:(id)sender {
    if (self.btnClickBlock) {
        self.btnClickBlock();
    }
}

@end
