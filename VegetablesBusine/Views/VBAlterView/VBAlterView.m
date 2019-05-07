//
//  VBAlterView.m
//  VegetablesBusine
//
//  Created by 刘少轩 on 2018/5/21.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "VBAlterView.h"

@implementation VBAlterView

VBAlterView *alterView = nil;

+ (instancetype)alterView{
    alterView = [[[NSBundle mainBundle] loadNibNamed:@"VBAlterView" owner:self options:nil] lastObject];
    alterView.contentView.layer.cornerRadius = 2.5;
    alterView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    return alterView;
}

- (void)setTitle:(NSString *)title confirmButtonTitle:(NSString *)confirmTitle cancleButtonTitle:(NSString *)cancleTitle{
    self.titleLabel.text = title;
    [self.cancleButton setTitle:cancleTitle forState:UIControlStateNormal];
    [self.confirmButton setTitle:confirmTitle forState:UIControlStateNormal];
}
- (void)show{
    CAKeyframeAnimation *popAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    popAnimation.duration = 0.4;
    popAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01f, 0.01f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1f, 1.1f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9f, 0.9f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DIdentity]];
    popAnimation.keyTimes = @[@0.0f, @0.5f, @0.75f, @1.0f];
    popAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [self.contentView.layer addAnimation:popAnimation forKey:nil];
    UIWindow *keyWindons = [UIApplication sharedApplication].keyWindow;
    [keyWindons addSubview:alterView];
}

- (IBAction)buttonClick:(UIButton *)sender{
    switch (sender.tag) {
        case 101:
        {
            if(self.cancleBlock){
                self.cancleBlock();
            }
        }
            break;
        case 102:
        {
            if(self.makeSureBlock){
                self.makeSureBlock();
            }
        }
            break;
            
        default:
            break;
    }
    [alterView removeFromSuperview];
    [alterView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

@end
