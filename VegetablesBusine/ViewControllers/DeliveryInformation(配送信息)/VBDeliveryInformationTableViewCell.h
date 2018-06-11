//
//  VBDeliveryInformationTableViewCell.h
//  VegetablesBusine
//
//  Created by Apple on 2018/6/11.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RACSubject;

@interface VBDeliveryInformationTableViewCell : UITableViewCell<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (strong, nonatomic) RACSubject *textFieldSubject;

@end
