//
//  VBAddGoodsInfoTextFieldTableViewCell.h
//  VegetablesBusine
//
//  Created by 刘少轩 on 2018/6/28.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface VBAddGoodsInfoTextFieldTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextField *infoTextField;
@property (copy, nonatomic)void(^inputBlock)(NSString *);
@end
