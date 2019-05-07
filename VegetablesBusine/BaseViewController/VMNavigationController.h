//
//  VMNavigationController.h
//  VegetableManagement
//
//  Created by Apple on 2018/3/30.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VMNavigationController : UINavigationController<UINavigationControllerDelegate>

- (UIScreenEdgePanGestureRecognizer *)screenEdgePanGestureRecognizer;

@end
