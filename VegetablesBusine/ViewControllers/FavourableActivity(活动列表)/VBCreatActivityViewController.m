//
//  VBCreatActivityViewController.m
//  VegetablesBusine
//
//  Created by Apple on 2018/6/26.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "VBCreatActivityViewController.h"

@interface VBCreatActivityViewController ()

@end

@implementation VBCreatActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)activityEditingGesture:(UITapGestureRecognizer *)sender {
    UIView *touchView = sender.view;
    NSInteger index = touchView.tag;
    NSLog(@"-----%ld",(long)index);
    Class ViewControllerClass = nil;
    switch (index-100) {
            //满减活动
        case 0:
        {
            ViewControllerClass = NSClassFromString(@"VBFullReductionActivityViewController");
        }
            break;
            //满赠活动
        case 1:
        {
            ViewControllerClass = NSClassFromString(@"VBGivingActivityViewController");
        }
            break;
            //折扣活动
        case 2:
        {
            ViewControllerClass = NSClassFromString(@"VBDiscountActivityViewController");
        }
            break;
            //免费配送
        case 3:
        {
            
        }
            break;
            
        default:
            break;
    }
    UIViewController *vc = [[ViewControllerClass alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
