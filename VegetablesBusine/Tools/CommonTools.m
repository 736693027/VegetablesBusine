//
//  CommonTools.m
//  tradework
//
//  Created by Jeser Zhang on 12-7-21.
//  Copyright (c) 2012年 Souche Holding Inc. All rights reserved.
//

#import "CommonTools.h"
#import <SystemConfiguration/SystemConfiguration.h>
#include <netinet/in.h>
#import <CommonCrypto/CommonDigest.h>

@implementation CommonTools

/*
 判断屏幕尺寸
 */
+(BOOL)iPhone6{
    if (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0) {
        return YES;
    }else{
        return NO;
    }
}

+(BOOL)iPhone6plus{
    if (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0) {
        return YES;
    }else{
        return NO;
    }
}

+(BOOL)iPhone5s{
    if (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0) {
        return YES;
    }else{
        return NO;
    }
}

+(BOOL)iPhone4{
    if (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0) {
        return YES;
    }else{
        return NO;
    }
}

/*
 MD5加密(登陆页用到)
 */
+ (NSString *)generateMD5:(NSString *)srcString
{
    const char *cStr = [srcString UTF8String];
    unsigned char result[16];
    if(cStr!=nil)
        CC_MD5( cStr, strlen(cStr), result);
    
    return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] uppercaseString];
}
/**
 *颜色值转换成图片
 */

+ (UIImage*)createImageWithColor: (UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage*theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}
/*
 颜色数值转换:#ababab
 */
+(UIColor *)changeColor:(NSString *)str{
    if ([str length] <6){//长度不合法
        return [UIColor blackColor];
    }
    NSString *tempString=[str lowercaseString];
    if ([tempString hasPrefix:@"0x"]){//检查开头是0x
        tempString = [tempString substringFromIndex:2];
    }else if ([tempString hasPrefix:@"#"]){//检查开头是#
        tempString = [tempString substringFromIndex:1];
    }
    if ([tempString length] !=6){
        return [UIColor blackColor];
    }
    //分解三种颜色的值
    NSRange range;
    range.location =0;
    range.length =2;
    NSString *rString = [tempString substringWithRange:range];
    range.location =2;
    NSString *gString = [tempString substringWithRange:range];
    range.location =4;
    NSString *bString = [tempString substringWithRange:range];
    //取三种颜色值
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString]scanHexInt:&r];
    [[NSScanner scannerWithString:gString]scanHexInt:&g];
    [[NSScanner scannerWithString:bString]scanHexInt:&b];
    return [UIColor colorWithRed:((float) r /255.0f)
                           green:((float) g /255.0f)
                            blue:((float) b /255.0f)
                           alpha:1.0f];
}
/*
 颜色数值转换:#ababab  透明度 alpha
 */
+(UIColor *)changeColor:(NSString *)str alpha:(CGFloat )alpha{
    unsigned int red,green,blue;
    NSString * str1 = [str substringWithRange:NSMakeRange(1, 2)];
    NSString * str2 = [str substringWithRange:NSMakeRange(3, 2)];
    NSString * str3 = [str substringWithRange:NSMakeRange(5, 2)];
    
    NSScanner * canner = [NSScanner scannerWithString:str1];
    [canner scanHexInt:&red];
    
    canner = [NSScanner scannerWithString:str2];
    [canner scanHexInt:&green];
    
    canner = [NSScanner scannerWithString:str3];
    [canner scanHexInt:&blue];
    UIColor * color = [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:alpha];
    return color;
}
/**
 是否存在网络
 */
+ ( BOOL )isNetworkReachable{

    // Create zero addy
    
    struct sockaddr_in zeroAddress;
    
    bzero (&zeroAddress, sizeof (zeroAddress));
    
    zeroAddress. sin_len = sizeof (zeroAddress);
    
    zeroAddress. sin_family = AF_INET ;
    
    // Recover reachability flags
    
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress ( NULL , ( struct sockaddr *)&zeroAddress);
    
    SCNetworkReachabilityFlags flags;
    
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags (defaultRouteReachability, &flags);
    
    CFRelease (defaultRouteReachability);
    
    if (!didRetrieveFlags)
        
    {
        
        return NO ;
        
    }
    
    BOOL isReachable = flags & kSCNetworkFlagsReachable ;
    
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired ;
    
    return (isReachable && !needsConnection) ? YES : NO ;
    
}

/**
 获取当前屏幕显示的viewcontroller
 */
+ (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    //app默认windowLevel是UIWindowLevelNormal，如果不是，找到UIWindowLevelNormal的
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    id  nextResponder = nil;
    UIViewController *appRootVC=window.rootViewController;
    //    如果是present上来的appRootVC.presentedViewController 不为nil
    if (appRootVC.presentedViewController) {
        nextResponder = appRootVC.presentedViewController;
    }else{
        UIView *frontView = [[window subviews] objectAtIndex:0];
        nextResponder = [frontView nextResponder];
    }
    
    if ([nextResponder isKindOfClass:[UITabBarController class]]){
        UITabBarController * tabbar = (UITabBarController *)nextResponder;
        UINavigationController * nav = (UINavigationController *)tabbar.viewControllers[tabbar.selectedIndex];
        //        UINavigationController * nav = tabbar.selectedViewController ; 上下两种写法都行
        result=nav.childViewControllers.lastObject;
        
    }else if ([nextResponder isKindOfClass:[UINavigationController class]]){
        UIViewController * nav = (UIViewController *)nextResponder;
        result = nav.childViewControllers.lastObject;
    }else{
        result = nextResponder;
    }
    
    return result;
}

+(NSString *)getNetWorkStates{
    UIApplication *app = [UIApplication sharedApplication];
    NSArray *children = [[[app valueForKeyPath:@"statusBar"]valueForKeyPath:@"foregroundView"]subviews];
    NSString *state = [[NSString alloc]init];
    int netType = 0;
    //获取到网络返回码
    for (id child in children) {
        if ([child isKindOfClass:NSClassFromString(@"UIStatusBarDataNetworkItemView")]) {
            //获取到状态栏
            netType = [[child valueForKeyPath:@"dataNetworkType"]intValue];
            
            switch (netType) {
                case 0:
                    state = @"0";
                    //无网模式
                    break;
                case 1:
                    state = @"2G";
                    break;
                case 2:
                    state = @"3G";
                    break;
                case 3:
                    state = @"4G";
                    break;
                case 5:
                {
                    state = @"WIFI";
                }
                    break;
                default:
                    break;
            }
        }
    }
    //根据状态选择
    return state;
}

+ (NSComparisonResult)compareDate:(NSString *)dateString withOtherDate:(NSString *)otherDateString{
    dateString = [dateString stringByReplacingOccurrencesOfString:@"." withString:@"-"];
    otherDateString = [otherDateString stringByReplacingOccurrencesOfString:@"." withString:@"-"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    NSDate *date = [dateFormatter dateFromString:dateString];
    NSDate *otherDate = [dateFormatter dateFromString:otherDateString];
    return [date compare:otherDate];
}
@end
