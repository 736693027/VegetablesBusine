//
//  VBActivityListViewController.m
//  VegetablesBusine
//
//  Created by Apple on 2018/6/26.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "VBActivityListViewController.h"
#import "VBActivityListDataViewController.h"
#import "UIView+YYAdd.h"

@interface VBActivityListViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *tabSegmentedControl;
@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;
@property (assign, nonatomic) NSInteger currentIndex;
@end

@implementation VBActivityListViewController

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    for(NSInteger i=0;i<4;i++){
        VBActivityListDataViewController *activityListDataVC = [[VBActivityListDataViewController alloc] init];
        [activityListDataVC didMoveToParentViewController:self];
        activityListDataVC.view.frame = CGRectMake(i*SCREEN_WIDTH, 0, SCREEN_WIDTH, self.mainScrollView.frame.size.height);
        [self.mainScrollView addSubview:activityListDataVC.view];
        [self addChildViewController:activityListDataVC];
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
    self.mainScrollView.contentSize = CGSizeMake(SCREEN_WIDTH*4, self.mainScrollView.contentSize.height);
    
    self.currentIndex = 0; //tab标签的位置
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

@end
