//
//  VBCalendarViewController.h
//  VegetablesBusine
//
//  Created by 刘少轩 on 2018/6/9.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "BaseViewController.h"
@class RACSubject;

@interface VBCalendarViewController : BaseViewController

@property (strong, nonatomic) RACSubject *dateSubject;

@end
