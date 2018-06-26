//
//  VBFavourableActivityViewController.m
//  VegetablesBusine
//
//  Created by Apple on 2018/6/25.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "VBFavourableActivityViewController.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import <Masonry/Masonry.h>
#import "VBTitleView.h"
#import "VBCreatActivityViewController.h"
#import "VBActivityListViewController.h"

@interface VBFavourableActivityViewController ()<UIScrollViewDelegate>{
    VBTitleView *titleView;
}
@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;

@end

@implementation VBFavourableActivityViewController

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    VBCreatActivityViewController *activityVC = [[VBCreatActivityViewController alloc] init];
    [self addChildViewController:activityVC];
    [self.mainScrollView addSubview:activityVC.view];
    activityVC.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.mainScrollView.frame.size.height);
    activityVC.view.backgroundColor = [CommonTools changeColor:@"0xf0f0f0"];
    
    VBActivityListViewController *activityListVC = [[VBActivityListViewController alloc] init];
    [self addChildViewController:activityListVC];
    [self.mainScrollView addSubview:activityListVC.view];
    activityListVC.view.frame = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, self.mainScrollView.frame.size.height);
    [self.view layoutSubviews];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mainScrollView.contentSize = CGSizeMake(SCREEN_WIDTH*2, self.mainScrollView.contentSize.height);
    
    titleView = [[VBTitleView alloc] initWithFrame:CGRectMake(0, 0, 200, 45)];
    titleView.selectIndexSubject = [RACSubject subject];
    [titleView.selectIndexSubject subscribeNext:^(NSNumber  *_Nullable index) {
        [self.mainScrollView setContentOffset:CGPointMake(index.integerValue*SCREEN_WIDTH, 0) animated:YES];
    }];
    self.navigationItem.titleView = titleView;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x/SCREEN_WIDTH;
    [titleView selectWithIndex:index];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
