//
//  VBActivieSelectWeekTableViewCell.h
//  VegetablesBusine
//
//  Created by 刘少轩 on 2018/6/30.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VBActivieSelectWeekTableViewCell : UITableViewCell
@property (strong, nonatomic) RACSubject *selectWeekSubject;
@property (copy, nonatomic) NSString *selectWeekResult;
@end
