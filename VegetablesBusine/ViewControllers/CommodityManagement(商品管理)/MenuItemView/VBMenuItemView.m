//
//  VBMenuItemView.m
//  VegetablesBusine
//
//  Created by Apple on 2018/5/31.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "VBMenuItemView.h"

@implementation VBMenuItemView

- (void)setControlState:(UIControlState)controlState{
    _controlState = controlState;
    switch (controlState) {
        case UIControlStateNormal:
        {
            self.backgroundColor = [CommonTools changeColor:@"0xefefef"];
            self.titleLabel.textColor = [CommonTools changeColor:@"0x666666"];
        }
            break;
        case UIControlStateSelected:
        {
            self.backgroundColor = [CommonTools changeColor:@"0xffffff"];
            self.titleLabel.textColor = [CommonTools changeColor:@"0x000000"];
        }
            break;
            
        default:
            break;
    }
}

@end
