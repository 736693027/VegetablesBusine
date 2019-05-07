//
//  VBGivingActivityTableViewCell.h
//  VegetablesBusine
//
//  Created by 刘少轩 on 2018/7/1.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VBGivingActivityTableViewCell : UITableViewCell<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) RACSubject *inputResultSubject;
@end
