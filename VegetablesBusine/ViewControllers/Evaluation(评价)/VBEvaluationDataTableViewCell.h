//
//  VBEvaluationDataTableViewCell.h
//  VegetablesBusine
//
//  Created by 刘少轩 on 2018/6/24.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class VBEvaluationDataModel;

@interface VBEvaluationDataTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *starRateView;
@property (weak, nonatomic) UIViewController *viewController;
@property (strong, nonatomic) VBEvaluationDataModel *itemModel;
@property (strong, nonatomic) RACSubject *replySuccessSubject;
@end
