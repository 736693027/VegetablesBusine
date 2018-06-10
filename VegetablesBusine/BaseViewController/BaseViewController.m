//
//  BaseViewController.m
//  VegetableManagement
//
//  Created by Apple on 2018/3/29.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "BaseViewController.h"
#import "UIButton+EnlargeEdge.h"

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
    
    navLeftBtn.frame=CGRectMake(0, 0, 44, 44);
    [navLeftBtn setEnlargeEdgeWithTop:10 right:10 bottom:10 left:10];
    navLeftBtn.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 20);
    [navLeftBtn setImage:[UIImage imageNamed:@"icon_returnx"] forState:UIControlStateNormal];
    navLeftBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [navLeftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [navLeftBtn addTarget:self action:@selector(navLeftButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:navLeftBtn];
    
    navRrightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    navRrightBtn.frame=CGRectMake(0, 0, 42, 42);
    [navRrightBtn setEnlargeEdgeWithTop:10 right:10 bottom:10 left:10];
    navRrightBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
    navRrightBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [navRrightBtn addTarget:self action:@selector(navRightButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:navRrightBtn];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
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
