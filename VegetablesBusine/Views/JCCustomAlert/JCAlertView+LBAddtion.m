//
//  JCAlertView+LBAddtion.m
//  LBBuyer
//
//  Created by demoker on 15/12/28.
//  Copyright © 2015年 Lubao. All rights reserved.
//

#import "JCAlertView+LBAddtion.h"
#import "LBCustomAlertView.h"
#import "LBAbnormalLoginAlertView.h"

@implementation JCAlertView (LBAddtion)

+ (void)showAlertViewWithTitle:(NSString*)title Description:(NSString *)desc left:(void(^)(id))left right:(void(^)(id))right{
    
    LBCustomAlertView * help = [LBCustomAlertView loadAlertViewWithTitle:title Description:desc left:left right:right];
    
    help.frame = CGRectMake(0, 0, SCREEN_WIDTH-40, help.frame.size.height);
    JCAlertView * alert = [[JCAlertView alloc]initWithCustomView:help dismissWhenTouchedBackground:NO];
    help.delegate = alert;
    [alert show];
}

+(void)showAlertViewWithTitle:(NSString *)title leftTitle:(NSString *)lTitle rightTitle:(NSString *)rTitle Description:(NSString *)desc left:(void (^)(id))left right:(void (^)(id))right{

    LBCustomAlertView * help = [LBCustomAlertView loadAlertViewWithTitle:title leftBtnTitle:lTitle rightTitle:rTitle Description:desc left:left right:right];
    
    help.frame = CGRectMake(0, 0, SCREEN_WIDTH-40, help.frame.size.height);
    JCAlertView * alert = [[JCAlertView alloc]initWithCustomView:help dismissWhenTouchedBackground:NO];
    help.delegate = alert;
    [alert show];
}

+ (void)showAbnormalLoginAlertWithReLoginBlock:(void(^)(id))reLoginBlock{
    LBAbnormalLoginAlertView * abnormalLogin = [[[NSBundle mainBundle] loadNibNamed:@"LBAbnormalLoginAlertView" owner:self options:nil] lastObject];
    abnormalLogin.frame = CGRectMake(0, 0, SCREEN_WIDTH-40, abnormalLogin.frame.size.height);
    abnormalLogin.reLogin = reLoginBlock;
    JCAlertView * alert = [[JCAlertView alloc]initWithCustomView:abnormalLogin dismissWhenTouchedBackground:NO];
    abnormalLogin.delegate = alert;
    [alert show];
}

@end
