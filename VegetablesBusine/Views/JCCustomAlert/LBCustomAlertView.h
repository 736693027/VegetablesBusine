//
//  LBProxyHelpAlertView.h
//  LBBuyer
//
//  Created by demoker on 15/12/25.
//  Copyright © 2015年 Lubao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JCAlertView.h"

@interface LBCustomAlertView : UIView
@property (assign, nonatomic) JCAlertView * delegate;
/*!
 *  @author ma dongkai, 15-12-26 10:12:51
 *
 *  @brief  帮助提示框生成方法
 *
 *  @param desc 描述
 *
 *  @return 对象
 *
 *  @since 1.0
 */
+ (instancetype)loadAlertViewWithTitle:(NSString *)title Description:(NSString *)desc left:(void(^)(id))left right:(void(^)(id))right;
+ (instancetype)loadAlertViewWithTitle:(NSString *)title leftBtnTitle:(NSString *)lTitle rightTitle:(NSString*)rTitle Description:(NSString *)desc left:(void(^)(id))left right:(void(^)(id))right;

@end
