//
//  LBAbnormalLoginAlertView.m
//  LBBuyer
//
//  Created by demoker on 15/12/28.
//  Copyright © 2015年 Lubao. All rights reserved.
//

#import "LBAbnormalLoginAlertView.h"

@interface LBAbnormalLoginAlertView ()

@property (weak, nonatomic) IBOutlet UIButton *resetLoginBtn;

@end

@implementation LBAbnormalLoginAlertView

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

- (void)awakeFromNib{
    self.layer.cornerRadius = 3;
    
    
    [_resetLoginBtn addTarget:self action:@selector(reLoginAction:) forControlEvents:UIControlEventTouchDown];
    
}

- (void)reLoginAction:(id)sender{
    if(self.reLogin){
        self.reLogin(self.delegate);
    }
}

@end
