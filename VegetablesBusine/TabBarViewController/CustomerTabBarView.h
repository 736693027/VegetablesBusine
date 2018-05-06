//
//  CustomerTabBarView.h
//  VegetableManagement
//
//  Created by Apple on 2018/3/30.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CustomerTabBarView;

@protocol CustomerTabBarViewDelegate <NSObject>

- (void)msTabBarView:(CustomerTabBarView *)view didSelectItemAtIndex:(NSInteger)index;

@end

@interface CustomerTabBarView : UIView

@property (nonatomic, weak) id<CustomerTabBarViewDelegate> viewDelegate;

/// 当前选中的位置
@property (nonatomic, assign) NSInteger selectIndex;

- (void)setItemBridge:(NSInteger)count atIndex:(NSInteger)index;

@end
