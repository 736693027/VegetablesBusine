//
//  VBAddGoodsPhotoTableViewCell.h
//  VegetablesBusine
//
//  Created by 刘少轩 on 2018/6/28.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class VBAddGoodsInfoModel;

@interface VBAddGoodsPhotoTableViewCell : UITableViewCell

@property (strong, nonatomic) VBAddGoodsInfoModel *itemModel;

@property (weak, nonatomic) UIViewController *viewController;

@property (strong ,nonatomic) RACSubject *uploadNewImageSubject;

@end
