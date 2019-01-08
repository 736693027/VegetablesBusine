//
//  LBProxyHelpAlertView.m
//  LBBuyer
//
//  Created by demoker on 15/12/25.
//  Copyright © 2015年 Lubao. All rights reserved.
//

#import "LBCustomAlertView.h"

@interface LBCustomAlertView ()
@property (weak, nonatomic) IBOutlet UILabel *proxyDesc;
@property (weak, nonatomic) IBOutlet UIButton *detailBtn;
@property (weak, nonatomic) IBOutlet UIButton *closeBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleLB;

@property (copy, nonatomic) void(^detail)(id sender);

@property (copy, nonatomic) void(^close)(id sender);
@end

@implementation LBCustomAlertView

+ (instancetype)loadAlertViewWithTitle:(NSString *)title Description:(NSString *)desc left:(void(^)(id))left right:(void(^)(id))right{
    LBCustomAlertView * alertView = [[[NSBundle mainBundle] loadNibNamed:@"LBCustomAlertView" owner:self options:nil] lastObject];
    alertView.titleLB.text = title;
    alertView.proxyDesc.text = desc;
    alertView.detail = left;
    alertView.close = right;
    return alertView;
}

+ (instancetype)loadAlertViewWithTitle:(NSString *)title leftBtnTitle:(NSString *)lTitle rightTitle:(NSString*)rTitle Description:(NSString *)desc left:(void(^)(id))left right:(void(^)(id))right{
    LBCustomAlertView * alertView = [[[NSBundle mainBundle] loadNibNamed:@"LBCustomAlertView" owner:self options:nil] lastObject];
    alertView.titleLB.text = title;
    alertView.proxyDesc.text = desc;
    alertView.detail = left;
    alertView.close = right;
    [alertView.detailBtn setTitle:lTitle forState:UIControlStateNormal];
    [alertView.closeBtn setTitle:rTitle forState:UIControlStateNormal];
    
    return alertView;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    
    self.layer.cornerRadius = 3;
    
    [_detailBtn addTarget:self action:@selector(detailAction:) forControlEvents:UIControlEventTouchDown];
    
    [_closeBtn addTarget:self action:@selector(closeAction:) forControlEvents:UIControlEventTouchDown];
}


- (void)detailAction:(id)sender{
    if(self.detail){
        self.detail(self.delegate);
    }
}

- (void)closeAction:(id)sender{
    if(self.close){
        self.close(self.delegate);
    }
}

@end
