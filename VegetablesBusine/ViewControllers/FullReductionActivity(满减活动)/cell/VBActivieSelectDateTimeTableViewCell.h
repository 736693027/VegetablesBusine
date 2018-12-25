//
//  VBActivieSelectDateTimeTableViewCell.h
//  VegetablesBusine
//
//  Created by 刘少轩 on 2018/6/30.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VBActivieSelectDateTimeTableViewCell : UITableViewCell

@property (strong, nonatomic) RACSubject *startDateTimeSubject;
@property (strong, nonatomic) RACSubject *endDateTimeSubject;

@end
