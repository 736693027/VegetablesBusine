//
//  VBStoreTypeTableViewCell.h
//  VegetablesBusine
//
//  Created by 刘少轩 on 2018/6/24.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class VBStoreTypeModel;

@interface VBStoreTypeTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *stateImageView;
@property (weak, nonatomic) IBOutlet UILabel *typeNameLabel;
@property (strong, nonatomic) VBStoreTypeModel *model;

@end
