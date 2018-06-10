//
//  VBShopIntroductionViewController.m
//  VegetablesBusine
//
//  Created by Apple on 2018/6/10.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "VBShopIntroductionViewController.h"
#import "UITextView+Placeholder.h"

@interface VBShopIntroductionViewController ()
@property (weak, nonatomic) IBOutlet UITextView *introductionTextView;

@end

@implementation VBShopIntroductionViewController

- (void)navRightButtonClicked:(UIButton *)sender{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"店铺简介";
    navRrightBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [navRrightBtn setTitle:@"保存" forState:UIControlStateNormal];
    [navRrightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.introductionTextView.placeholder = @"请输入店铺简介内容...";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
