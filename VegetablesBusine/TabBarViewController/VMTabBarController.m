//
//  VMTabBarController.m
//  VegetableManagement
//
//  Created by Apple on 2018/3/30.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "VMTabBarController.h"
#import "VMCustomTabBar.h"
#import "CustomerTabBarView.h"
#import "BaseViewController.h"
#import "VBWaitDealViewController.h"
#import "VMNavigationController.h"
#import "VBOrderManagerViewController.h"
#import "VBShoppingManagerViewController.h"
#import "VBSetupViewController.h"
#import "VMLoginViewController.h"
#import "VMLoginUserInfoModel.h"


@interface VMTabBarController ()<CustomerTabBarViewDelegate>{
    VMCustomTabBar *tabBar;
}

@end

@implementation VMTabBarController

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    VMLoginUserInfoModel *loginModel = [VMLoginUserInfoModel loginUsrInfoModel];
    if(!loginModel.sessionKey){
        NSString *homePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) objectAtIndex:0];
        NSString *loginPath = [homePath stringByAppendingPathComponent:@"login.data"];
        VMLoginUserInfoModel *archiverLoginUserInfo = [NSKeyedUnarchiver unarchiveObjectWithFile:loginPath];
        loginModel = [archiverLoginUserInfo copy];
        if(!loginModel.sessionKey){
            [self jumpToLoginViewController];
        }
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    tabBar = [[VMCustomTabBar alloc] init];
    tabBar.tabBarView.viewDelegate = self;
    [self setValue:tabBar forKey:@"tabBar"];
    
    [self addAllChildViewController];
    
    @weakify(self);
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:VMLogoutNotification object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        @strongify(self);
        [self jumpToLoginViewController];
    }];
}
#pragma mark 跳转到登录页面
- (void)jumpToLoginViewController{
    VMLoginViewController *loginVC = [[VMLoginViewController alloc] init];
    [self presentViewController:loginVC animated:YES completion:nil];
}
- (void)addAllChildViewController{
    VBWaitDealViewController *waitDealVC = [[VBWaitDealViewController alloc] init];
    [self addChildViewController:waitDealVC navTitle:@"待处理"];
   
    VBOrderManagerViewController *orderManagerVC = [[VBOrderManagerViewController alloc] init];
    [self addChildViewController:orderManagerVC navTitle:@"订单管理"];
    
    VBShoppingManagerViewController *deliverOrderVC = [[VBShoppingManagerViewController alloc] init];
    [self addChildViewController:deliverOrderVC navTitle:@"门店管理"];
    
    VBSetupViewController *setupVC = [[VBSetupViewController alloc] init];
    [self addChildViewController:setupVC navTitle:@"设置"];
}

- (void)addChildViewController:(UIViewController *)childController navTitle:(NSString *)title {
    VMNavigationController *nav = [[VMNavigationController alloc] initWithRootViewController:childController];
    childController.navigationItem.title = title;
    [self addChildViewController:nav];
}

- (void)msTabBarView:(CustomerTabBarView *)view didSelectItemAtIndex:(NSInteger)index{
    self.selectedIndex = index;
}

- (void)setTabBarItemBridge:(NSInteger)count withIndex:(NSInteger)index{
    [tabBar.tabBarView setItemBridge:count atIndex:index];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    CGRect frame = self.tabBar.frame;
    frame.size.height = TabBarHeight;
    frame.origin.y = self.view.frame.size.height - frame.size.height;
    self.tabBar.frame = frame;
//    self.tabBar.backgroundColor = [UIColor blackColor];
//    self.tabBar.barStyle = UIBarStyleBlack;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
