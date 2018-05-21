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

+ (instancetype)alterView;

- (void)show;
@end
