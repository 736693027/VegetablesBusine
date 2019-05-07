//
//  VBDiscountActivityTableViewCell.h
//  VegetablesBusine
//
//  Created by 刘少轩 on 2018/7/1.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VBDiscountActivityTableViewCell : UITableViewCell<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *unitLabel;
@property (weak, nonatomic) IBOutlet UITextField *inputTextField;
@property (strong, nonatomic) RACSubject *inputResultSubject;
@end
