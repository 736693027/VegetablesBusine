//
//  VBActivityRulesTableViewCell.h
//  VegetablesBusine
//
//  Created by 刘少轩 on 2018/6/30.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RACSubject;

@interface VBActivityRulesTableViewCell : UITableViewCell<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *editingButton;
@property (weak, nonatomic) IBOutlet UITextField *textField1;
@property (weak, nonatomic) IBOutlet UITextField *textField2;

@property (strong, nonatomic) RACSubject *rulesSubject;
@property (strong, nonatomic) RACSubject *rulesDataSubject;
@property (strong, nonatomic) NSIndexPath *indexPath;

@end
