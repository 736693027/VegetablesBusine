//
//  VBWaitDealViewController.m
//  VegetablesBusine
//
//  Created by Apple on 2018/5/8.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "VBWaitDealViewController.h"
#import "VBWaitDealTableViewController.h"
#import "VBRefundTableViewController.h"

@interface VBWaitDealViewController ()<UIScrollViewDelegate>{
    NSInteger currentIndex;
}
@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollview;

@property (weak, nonatomic) IBOutlet UIView *indicatorView;

@end

@implementation VBWaitDealViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"已完成";
    _mainScrollview.contentSize = CGSizeMake(SCREEN_WIDTH*2,_mainScrollview.frame.size.height);
    VBWaitDealTableViewController *waitDealTable = [[VBWaitDealTableViewController alloc] init];
    waitDealTable.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-kNavigationBarAndStatusHeight-50-kTabbarHeight);
    waitDealTable.tableTag = 1;
    [self addChildViewController:waitDealTable];
    [_mainScrollview addSubview:waitDealTable.view];
    
    VBRefundTableViewController *refundTable = [[VBRefundTableViewController alloc] init];
    refundTable.view.frame = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT-kNavigationBarAndStatusHeight-50-kTabbarHeight);
    refundTable.tableTag = 2;
    [self addChildViewController:refundTable];
    [_mainScrollview addSubview:refundTable.view];
}
- (IBAction)buttonClick:(UIButton *)sender {
    NSInteger index = sender.tag - 100;
    if(index!=currentIndex){
        UIButton *beforeBtn = [self.view viewWithTag:currentIndex+100];
        beforeBtn.selected = NO;
        [UIView animateWithDuration:0.3 animations:^{
            CGRect frame = self.indicatorView.frame;
            frame.origin.x = index*(SCREEN_WIDTH/2);
            self.indicatorView.frame = frame;
        }];
        [self.mainScrollview setContentOffset:CGPointMake(index*SCREEN_WIDTH, 0) animated:YES];
        currentIndex = index;
        sender.selected = YES;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x/SCREEN_WIDTH;
    if(index != currentIndex){
        [UIView animateWithDuration:0.3 animations:^{
            CGRect frame = self.indicatorView.frame;
            frame.origin.x = index*(SCREEN_WIDTH/2);
            self.indicatorView.frame = frame;
        }];
        UIButton *beforeBtn = [self.view viewWithTag:currentIndex+100];
        beforeBtn.selected = NO;
        UIButton *nextBtn = [self.view viewWithTag:index+100];
        nextBtn.selected = YES;
        currentIndex = index;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
