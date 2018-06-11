//
//  VBShopIntroductionViewController.m
//  VegetablesBusine
//
//  Created by Apple on 2018/6/10.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "VBShopIntroductionViewController.h"
#import "UITextView+Placeholder.h"
#import <ReactiveObjC/ReactiveObjC.h>

@interface VBShopIntroductionViewController ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *introductionTextView;

@end

@implementation VBShopIntroductionViewController

- (void)navRightButtonClicked:(UIButton *)sender{
    [self.introductionTextView resignFirstResponder];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    navRrightBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [navRrightBtn setTitle:@"保存" forState:UIControlStateNormal];
    [navRrightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    if(self.contentString.length>0){
        self.introductionTextView.text = self.contentString;
    }else{
        self.introductionTextView.placeholder = [NSString stringWithFormat:@"请输入%@信息...",self.title];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    if(self.textViewSubject){
        [self.textViewSubject sendNext:textView.text];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
