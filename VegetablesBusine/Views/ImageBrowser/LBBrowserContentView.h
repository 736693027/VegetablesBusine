//
//  LBBrowserContentView.h
//  LBAssistant
//
//  Created by zhengjunchao on 16/5/9.
//  Copyright © 2016年 FSLB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LBBrowserContentView : UIView

@property (nonatomic, copy) void(^handleDirenctionBlock)(UISwipeGestureRecognizerDirection direction);

@property (nonatomic, copy) NSString * text;

- (instancetype)initWithTableViewHeight:(CGFloat)height;

@end
