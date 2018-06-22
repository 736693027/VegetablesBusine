//
//  BusinessTimeView.h
//  VegetablesBusine
//
//  Created by Apple on 2018/6/21.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RACSubject;

@interface BusinessTimeView : UIView

@property (nonatomic, assign) BOOL selectState;
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) RACSubject *gestureSubject;
@end
