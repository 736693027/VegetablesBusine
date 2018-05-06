//
//  BaseViewController.h
//  VegetableManagement
//
//  Created by Apple on 2018/3/29.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController{
    UIButton *navRrightBtn;//导航右侧按钮
    UIButton *navLeftBtn;//导航左侧按钮
}
- (void)navLeftButtonClicked:(UIButton *)sender;

- (void)navRightButtonClicked:(UIButton *)sender;
@end
