//
//  JCAlertView+LBAddtion.h
//  LBBuyer
//
//  Created by demoker on 15/12/28.
//  Copyright © 2015年 Lubao. All rights reserved.
//

#import "JCAlertView.h"

@interface JCAlertView (LBAddtion)

/*!
 *  @author ma dongkai, 16-12-28 13:12:15
 *
 *  @brief  设置通用提示框
 *
 *  @param title 提示框标题
 *  @param desc  帮助文字简述
 *  @param left  左边按钮（查看详情）
 *  @param right 右边按钮（关闭）
 *
 *  @since 1.0
 */
+ (void)showAlertViewWithTitle:(NSString*)title Description:(NSString *)desc left:(void(^)(id))left right:(void(^)(id))right;
+(void)showAlertViewWithTitle:(NSString *)title leftTitle:(NSString *)lTitle rightTitle:(NSString *)rTitle Description:(NSString *)desc left:(void (^)(id))left right:(void (^)(id))right;

/*!
 *  @author ma dongkai, 16-12-28 14:12:08
 *
 *  @brief  登录异常
 *
 *  @param reLoginBlock 重新登录
 *
 *  @since 1.0
 */
+ (void)showAbnormalLoginAlertWithReLoginBlock:(void(^)(id))reLoginBlock;


//***********************************原cp*****************************************
/*!
 *  @author ma dongkai, 16-03-02 14:03:13
 *
 *  @brief 提交报价确认提示框
 *
 *  @param price 报价
 *  @param left  回调
 *  @param right 回调
 *
 *  @since 1.0
 */
+ (void)showSubmmitPriceSureAlertViewWithPrice:(NSString*)price left:(void(^)(id))left right:(void(^)(id))right;

/*!
 *  @author ma dongkai, 16-03-02 14:03:58
 *
 *  @brief 提交报价成功
 *
 *  @param desc desc description
 *  @param sure sure description
 *
 *  @since 1.0
 */
+ (void)showSubmmitPriceSuccessAlertViewWithDescription:(NSString*)desc sure:(void(^)(id))sure;


@end
