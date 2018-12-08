//
//  VMSectionHeaderView.m
//  VegetableManagement
//
//  Created by Apple on 2018/4/12.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "VMSectionHeaderView.h"

@interface VMSectionHeaderView ()

@property (weak, nonatomic) IBOutlet UIButton *shoppingListButton;

@end

@implementation VMSectionHeaderView

- (void)setIsCloseListData:(BOOL)isCloseListData {
    _isCloseListData = isCloseListData;
    if(isCloseListData){
        [self.shoppingListButton setImage:[UIImage imageNamed:@"pendingNewlaunchx_down"] forState:UIControlStateNormal];
    }else{
        [self.shoppingListButton setImage:[UIImage imageNamed:@"pendingNewlaunchx"] forState:UIControlStateNormal];
    }
}
- (IBAction)closeListButtonClick:(UIButton *)sender{
    if(self.isCloseListData){
        sender.transform = CGAffineTransformRotate(sender.transform, 0);
    }else{
        sender.transform = CGAffineTransformRotate(sender.transform, M_PI);
    }
    if(self.updataHeadViewSubject){
        [self.updataHeadViewSubject sendNext:@""];
    }
}

@end
