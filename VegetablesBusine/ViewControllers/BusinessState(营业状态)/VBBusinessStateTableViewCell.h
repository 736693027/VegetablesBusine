//
//  VBBusinessStateTableViewCell.h
//  VegetablesBusine
//
//  Created by Apple on 2018/6/12.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RACSubject;

@interface VBBusinessStateTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *startDateTimeView;
@property (weak, nonatomic) IBOutlet UILabel *startHourLabel;
@property (weak, nonatomic) IBOutlet UILabel *startMinutesLabel;
@property (weak, nonatomic) IBOutlet UIView *endDateTimeView;
@property (weak, nonatomic) IBOutlet UILabel *endHourLabel;
@property (weak, nonatomic) IBOutlet UILabel *endMinutesLabel;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (strong, nonatomic) RACSubject *selectStartDateTime;
@property (strong, nonatomic) RACSubject *selectEndDateTime;
@property (strong, nonatomic) RACSubject *deleteDateTime;

@end
