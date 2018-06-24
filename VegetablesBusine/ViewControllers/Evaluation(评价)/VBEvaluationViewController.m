//
//  VBEvaluationViewController.m
//  VegetablesBusine
//
//  Created by 刘少轩 on 2018/6/24.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "VBEvaluationViewController.h"
#import "UIView+YYAdd.h"
#import "VBEvaluationDataViewController.h"

@interface VBEvaluationViewController ()<UIScrollViewDelegate>

@property (nonatomic) NSInteger currentIndex;
@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;
@property (weak, nonatomic) IBOutlet UIView *buttonMainView;

@end

@implementation VBEvaluationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (@available(iOS 11.0, *)) {
        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:(UIScrollViewContentInsetAdjustmentNever)];
    } else {
        self.mainScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    self.mainScrollView.contentSize = CGSizeMake(SCREEN_WIDTH*4, self.mainScrollView.height-64);
    for(NSInteger i=0;i<4;i++){
        VBEvaluationDataViewController *evaluationDataVC = [[VBEvaluationDataViewController alloc] init];
        evaluationDataVC.view.frame = CGRectMake(i*SCREEN_WIDTH, 0, SCREEN_WIDTH, self.mainScrollView.height);
        [self.mainScrollView addSubview:evaluationDataVC.view];
        [self addChildViewController:evaluationDataVC];
    }
    self.currentIndex = 0; //tab标签的位置
    self.title = @"顾客评价";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (IBAction)tabButtonItemClick:(UIButton *)sender {
    NSInteger index = sender.tag - 333;
    if(index != self.currentIndex){
        UIButton *beforeButton = [self.buttonMainView viewWithTag:self.currentIndex+333];
        beforeButton.selected = !beforeButton.selected;
        sender.selected = !sender.selected;
        [self.mainScrollView setContentOffset:CGPointMake(index*SCREEN_WIDTH, 0) animated:YES];
        self.currentIndex = index;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x/SCREEN_WIDTH;
    if(index != self.currentIndex){
        UIButton *beforeButton = [self.buttonMainView viewWithTag:self.currentIndex+333];
        beforeButton.selected = !beforeButton.selected;
        
        UIButton *nextButton = [self.buttonMainView viewWithTag:index+333];
        nextButton.selected = !nextButton.selected;
        self.currentIndex = index;
    }
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
