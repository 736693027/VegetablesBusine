//
//  LBDatePickerView.h
//  LBAssistant
//
//  Created by Apple on 2018/5/16.
//  Copyright © 2018年 FSLB. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RACSubject;

@interface LBDatePickerView : UIView

@property (strong, nonatomic) RACSubject *resultSubject;

+ (instancetype)initPickView;

- (void)showPickView;

@end
