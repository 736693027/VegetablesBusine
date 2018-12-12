//
//  DefineFile.h
//  VegetableManagement
//
//  Created by Apple on 2018/3/29.
//  Copyright © 2018年 Apple. All rights reserved.
//

#ifndef DefineFile_h
#define DefineFile_h

#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))


// status bar height.

#define  kStatusBarHeight      [[UIApplication sharedApplication] statusBarFrame].size.height

// Navigation bar height.

#define  kNavigationBarHeight  44.f

#define  kNavigationBarAndStatusHeight  (kStatusBarHeight + kNavigationBarHeight)

// Tabbar height.

#define  kTabbarHeight        (IS_iPhoneX ? (68.f+34.f) : 68.f)

// Tabbar safe bottom margin.

#define  kTabbarSafeBottomMargin        (IS_iPhoneX ? 34.f : 0.f)

// Status bar & navigation bar height.

#define  kStatusBarAndNavigationBarHeight  (IS_iPhoneX ? 88.f : 64.f)

//判断是否iPhone X

#define IS_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

#define OBJC(v) (([v isEqual:[NSNull null]] | [v isEqual:@"(null)"] | [v isEqual:@"<null>"] | v== nil) ? @"" : v)

#define PlaceHolderImage [UIImage imageNamed:@""]

#endif /* DefineFile_h */
