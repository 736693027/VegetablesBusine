//
//  VBAlterView.h
//  VegetablesBusine
//
//  Created by 刘少轩 on 2018/5/21.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VBAlterView : UIView

@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *cancleButton;
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;

+ (instancetype)alterView;

- (void)setTitle:(NSString *)title confirmButtonTitle:(NSString *)confirmTitle cancleButtonTitle:(NSString *)cancleTitle;

- (void)show;
@end
