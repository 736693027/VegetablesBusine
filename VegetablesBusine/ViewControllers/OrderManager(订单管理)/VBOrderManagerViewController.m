//
//  VBOrderManagerViewController.m
//  VegetablesBusine
//
//  Created by Apple on 2018/5/9.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "VBOrderManagerViewController.h"
#import "VBOrderManagerTableViewViewController.h"
#import "VBCalendarViewController.h"
#import <ReactiveObjC/ReactiveObjC.h>

@interface VBOrderManagerViewController ()<UIScrollViewDelegate>{
    NSInteger currentIndex;
}
@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollview;

@property (weak, nonatomic) IBOutlet UIView *indicatorView;

@end

@implementation VBOrderManagerViewController

#pragma mark 选择日期
- (void)navLeftButtonClicked:(UIButton *)sender{
    VBCalendarViewController *calendarVC = [[VBCalendarViewController alloc] init];
    calendarVC.dateSubject = [RACSubject subject];
    __weak typeof(navLeftBtn) weakButton = navLeftBtn;
    [calendarVC.dateSubject subscribeNext:^(NSDate  *_Nullable date) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd.MM.yyyy"];
        NSString *dateTime = [dateFormatter stringFromDate:date];
        [weakButton setTitle:dateTime forState:UIControlStateNormal];
    }];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:calendarVC];
    [self presentViewController:nav animated:YES completion:nil];
}
#pragma mark 订单搜索
- (void)navRightButtonClicked:(UIButton *)sender{
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd.MM.yyyy"];
    NSString *dateTime = [dateFormatter stringFromDate:[NSDate date]];
    [navLeftBtn setTitle:dateTime forState:UIControlStateNormal];
    [navLeftBtn setImage:[UIImage imageNamed:@"icon_selectDateDown"] forState:UIControlStateNormal];
    navLeftBtn.contentEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
    navLeftBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    navLeftBtn.semanticContentAttribute = UISemanticContentAttributeForceRightToLeft;
    self.title = @"订单管理";
    
    _mainScrollview.contentSize = CGSizeMake(SCREEN_WIDTH*2,SCREEN_HEIGHT-STATUSBARHEIGHT-NAVIGATIONBARHEIGHT-50-TabBarHeight);
    for(NSInteger i=0;i<2;i++){
        VBOrderManagerTableViewViewController *orderManagerTable = [[VBOrderManagerTableViewViewController alloc] init];
        orderManagerTable.view.frame = CGRectMake(i*SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT-STATUSBARHEIGHT-NAVIGATIONBARHEIGHT-50-TabBarHeight);
        orderManagerTable.viewStyle = i==0?VBOrderManagerTableViewStyleloading:VBOrderManagerTableViewStyleFinished;
        [self addChildViewController:orderManagerTable];
        [_mainScrollview addSubview:orderManagerTable.view];
    }
}
#pragma mark 标签页切换
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
