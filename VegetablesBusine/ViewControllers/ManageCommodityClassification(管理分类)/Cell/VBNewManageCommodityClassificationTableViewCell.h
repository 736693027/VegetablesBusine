//
//  VBNewManageCommodityClassificationTableViewCell.h
//  VegetablesBusine
//
//  Created by 刘少轩 on 2018/6/27.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class VBManageCommodityClassificationModel,RACSubject;

@interface VBNewManageCommodityClassificationTableViewCell : UITableViewCell

@property (strong ,nonatomic) VBManageCommodityClassificationModel *itemModel;

@property (strong, nonatomic) RACSubject *deleteClassifySubject;

@property (strong, nonatomic) RACSubject *editingClassifySubject;

@end
