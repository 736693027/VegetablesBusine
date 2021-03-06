//
//  VBMerchantSettlementViewController.m
//  VegetablesBusine
//
//  Created by 刘少轩 on 2018/6/27.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "VBMerchantSettlementViewController.h"
#import "VBMerchantSettlementDataViewController.h"

@interface VBMerchantSettlementViewController ()<UIScrollViewDelegate>{
    NSInteger currentIndex;
}
@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollview;

@property (weak, nonatomic) IBOutlet UIView *indicatorView;

@end

@implementation VBMerchantSettlementViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBarTintColor:[CommonTools changeColor:@"0x45525B"]];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor blackColor]};
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商家结算";
    _mainScrollview.contentSize = CGSizeMake(SCREEN_WIDTH*3,self.mainScrollview.frame.size.height-64);
    for(NSInteger i=0;i<3;i++){
        VBMerchantSettlementDataViewController *orderManagerTable = [[VBMerchantSettlementDataViewController alloc] init];
        orderManagerTable.tabNumber = i+1;
        orderManagerTable.view.frame = CGRectMake(i*SCREEN_WIDTH, 0, SCREEN_WIDTH, self.mainScrollview.frame.size.height);
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
            frame.origin.x = index*(SCREEN_WIDTH/3);
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
            frame.origin.x = index*(SCREEN_WIDTH/3);
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
