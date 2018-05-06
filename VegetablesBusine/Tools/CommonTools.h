//
//  CommonTools.h
//  tradework
//
//  Created by Jeser Zhang on 12-7-21.
//  Copyright (c) 2012年 Souche Holding Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CommonTools : NSObject
/*
 判断屏幕尺寸
 */
+(BOOL)iPhone6;
+(BOOL)iPhone6plus;
+(BOOL)iPhone4;
+(BOOL)iPhone5s;

/*
 MD5加密
 */
+ (NSString *)generateMD5:(NSString *)srcString;

/**
 *颜色值转换成图片
 */

+ (UIImage*)createImageWithColor:(UIColor*) color;

/*
 颜色数值转换:#ababab
 */
+(UIColor *)changeColor:(NSString *)str;

/*
 颜色数值转换:#ababab  透明度 alpha
 */
+(UIColor *)changeColor:(NSString *)str alpha:(CGFloat )alpha;

/**
 是否存在网络
 */
+ ( BOOL )isNetworkReachable;
/**
 获取当前屏幕显示的viewcontroller
 */
+ (UIViewController *)getCurrentVC;

/**
 *  获取网络状态
 *
 *  @return 无网络，Wi-Fi，2G，3G，4G
 */
+(NSString *)getNetWorkStates;


/**
 比对俩个日期

 @param dateString 开始时间
 @param otherDateString 结束时间
 @return 对比结果
 */
+ (NSComparisonResult)compareDate:(NSString *)dateString withOtherDate:(NSString *)otherDateString;
@end
