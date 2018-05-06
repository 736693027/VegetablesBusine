//
//  BaseViewController.m
//  VegetableManagement
//
//  Created by Apple on 2018/3/29.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpNavgationItem];
}

- (void)setUpNavgationItem
{
    navLeftBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    
    navLeftBtn.frame=CGRectMake(0, 20, 44, 44);
    if ([CommonTools iPhone6plus]) {
        navLeftBtn.contentEdgeInsets = UIEdgeInsetsMake(0, -25, 0, 0);
    }else{
        navLeftBtn.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    }
    [navLeftBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    navLeftBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [navLeftBtn addTarget:self action:@selector(navLeftButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:navLeftBtn];
    
    navRrightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    navRrightBtn.frame=CGRectMake(0, 0, 42, 42);
    navRrightBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
    navRrightBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [navRrightBtn addTarget:self action:@selector(navRightButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rigthButtonSapce = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    rigthButtonSapce.width = -1;
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:navRrightBtn];
    self.navigationItem.rightBarButtonItems = @[rigthButtonSapce,rightBarButtonItem];
}

#pragma mark navigationItem BarButtonItem click
- (void)navLeftButtonClicked:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)navRightButtonClicked:(UIButton *)sender{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
