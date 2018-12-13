//
//  VMNavigationController.m
//  VegetableManagement
//
//  Created by Apple on 2018/3/30.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "VMNavigationController.h"

@interface VMNavigationController ()<UIGestureRecognizerDelegate>
@property (weak, nonatomic) UIViewController * currentShowVC;
@end

@implementation VMNavigationController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController{
    VMNavigationController *nav = [super initWithRootViewController:rootViewController];
    self.interactivePopGestureRecognizer.delegate = self;
    nav.delegate = self;
    return nav;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.barTintColor = [UIColor whiteColor];
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
    self.navigationBar.translucent = NO;
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if(navigationController.viewControllers.count == 1){
        self.currentShowVC = nil;
    }else{
        self.currentShowVC = viewController;
    }
}
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    if(gestureRecognizer == self.interactivePopGestureRecognizer){
        if(self.currentShowVC == self.topViewController){
            return YES;
        }
        return NO;
    }
    return YES;
}
- (UIScreenEdgePanGestureRecognizer *)screenEdgePanGestureRecognizer{
    UIScreenEdgePanGestureRecognizer *screenEdgePanGestureRecognizer = nil;
    if(self.view.gestureRecognizers.count > 0){
        for(UIGestureRecognizer *recognizer in  self.view.gestureRecognizers){
            if([recognizer isKindOfClass:[UIScreenEdgePanGestureRecognizer class]]){
                screenEdgePanGestureRecognizer = (UIScreenEdgePanGestureRecognizer *)recognizer;
                break;
            }
        }
    }
    return screenEdgePanGestureRecognizer;
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
