//
//  VBActivityListDataTableViewCell.h
//  VegetablesBusine
//
//  Created by 刘少轩 on 2018/6/26.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class VBActivityListModel;

@interface VBActivityListDataTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *activityTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *activityRuleLabel;
@property (weak, nonatomic) IBOutlet UILabel *activityDateTime;
@property (weak, nonatomic) IBOutlet UILabel *activityStateLabel;
@property (weak, nonatomic) IBOutlet UILabel *activityCreatDateTimeLabel;
@property (strong, nonatomic) VBActivityListModel *itemModel;
@property (strong, nonatomic) RACSubject *deleteSuccessSubject;
@end
