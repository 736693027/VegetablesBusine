//
//  VBBusinessStatisticsViewController.m
//  VegetablesBusine
//
//  Created by 刘少轩 on 2018/6/24.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "VBBusinessStatisticsViewController.h"
#import "UIView+YYAdd.h"
#import "VBBusinessStatisticsDataNormalViewController.h"
#import "VBBusinessStatisticsDataCustomViewController.h"

@interface VBBusinessStatisticsViewController ()

@property (weak, nonatomic) IBOutlet UISegmentedControl *tabSegmentedControl;
@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;
@property (assign, nonatomic) NSInteger currentIndex;

@end

@implementation VBBusinessStatisticsViewController

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    for(NSInteger i=0;i<4;i++){
        if(i==3){
            VBBusinessStatisticsDataCustomViewController *statisticsDataCustomVC = [[VBBusinessStatisticsDataCustomViewController alloc] init];
            [statisticsDataCustomVC didMoveToParentViewController:self];
            statisticsDataCustomVC.view.frame = CGRectMake(i*SCREEN_WIDTH, 0, SCREEN_WIDTH, self.mainScrollView.height);
            [self.mainScrollView addSubview:statisticsDataCustomVC.view];
            [self addChildViewController:statisticsDataCustomVC];
        }else{
            VBBusinessStatisticsDataNormalViewController *statisticsDataNormalVC = [[VBBusinessStatisticsDataNormalViewController alloc] init];
            [statisticsDataNormalVC didMoveToParentViewController:self];
            statisticsDataNormalVC.view.frame = CGRectMake(i*SCREEN_WIDTH, 0, SCREEN_WIDTH, self.mainScrollView.height);
            statisticsDataNormalVC.type = i+1;
            [self.mainScrollView addSubview:statisticsDataNormalVC.view];
            [self addChildViewController:statisticsDataNormalVC];
        }
    }
    [self.view layoutSubviews];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    if (@available(iOS 11.0, *)) {
        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:(UIScrollViewContentInsetAdjustmentNever)];
    } else {
        self.mainScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    self.mainScrollView.contentSize = CGSizeMake(SCREEN_WIDTH*4, self.mainScrollView.height-64);
    
    self.currentIndex = 0; //tab标签的位置
    self.title = @"营业统计";
}
#pragma mark segmentedControl click method
- (IBAction)segmentClick:(UISegmentedControl *)sender {
    NSInteger index = sender.selectedSegmentIndex;
    if(index != self.currentIndex){
        [self.mainScrollView setContentOffset:CGPointMake(index*SCREEN_WIDTH, 0) animated:YES];
        self.currentIndex = index;
    }
}
#pragma mark scrollview delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x/SCREEN_WIDTH;
    if(index != self.currentIndex){
        self.currentIndex = index;
        self.tabSegmentedControl.selectedSegmentIndex = index;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
