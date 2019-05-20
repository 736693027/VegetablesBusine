//
//  BaseViewController+LBOperateAction.m
//  LBAssistant
//
//  Created by demoker on 2018/3/23.
//  Copyright © 2018年 FSLB. All rights reserved.
//

#import "UIViewController+LBOperateAction.h"

@implementation UIViewController (LBOperateAction)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method iceViewDidAppear = class_getInstanceMethod(self, @selector(iceViewDidAppear:));
        Method viewDidAppear    = class_getInstanceMethod(self, @selector(viewDidAppear:));
        method_exchangeImplementations(viewDidAppear, iceViewDidAppear);
    });
}

- (void)iceViewDidAppear:(BOOL)animated {
    NSLog(@"当前控制器：>>>%@<<<",NSStringFromClass(self.class));
    [self iceViewDidAppear:animated];
}

@end
