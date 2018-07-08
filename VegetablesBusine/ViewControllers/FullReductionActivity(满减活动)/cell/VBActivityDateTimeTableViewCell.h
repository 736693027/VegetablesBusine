//
//  VBActivityDateTimeTableViewCell.h
//  VegetablesBusine
//
//  Created by 刘少轩 on 2018/6/30.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RACSubject;

@interface VBActivityDateTimeTableViewCell : UITableViewCell

@property (strong, nonatomic) RACSubject *activityTypeSubject;

@end
