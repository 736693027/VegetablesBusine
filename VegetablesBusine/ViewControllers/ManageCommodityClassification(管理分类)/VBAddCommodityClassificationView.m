//
//  VBAddCommodityClassificationView.m
//  VegetablesBusine
//
//  Created by 刘少轩 on 2018/5/21.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "VBAddCommodityClassificationView.h"
#import "VBManageCommodityClassificationModel.h"

typedef void (^ResultBlock)(NSString *, NSString *);
static ResultBlock myResultBlock;
static VBAddCommodityClassificationView *alterView = nil;

@interface VBAddCommodityClassificationView()

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *numberTextField;

@end

@implementation VBAddCommodityClassificationView

+ (instancetype)alterViewWithResult:(void (^)(NSString *, NSString *))resultBlock{
    myResultBlock = [resultBlock copy];
    alterView = [[[NSBundle mainBundle] loadNibNamed:@"VBAddCommodityClassificationView" owner:self options:nil] lastObject];
    alterView.contentView.layer.cornerRadius = 2.5;
    alterView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    return alterView;
}

- (void)show{
    [self.nameTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
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

- (void)textFieldDidChange:(UITextField *)textField{
    if(textField.text.length>10){
        textField.text = [textField.text substringToIndex:10];
    }
}
- (IBAction)cancelButtonClick:(id)sender{
    [alterView removeFromSuperview];
    [alterView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
}
- (IBAction)confirmButtonClick:(UIButton *)sender {
    if(myResultBlock){
        myResultBlock(self.nameTextField.text,self.numberTextField.text);
    }
}

- (void)setItemModel:(VBManageCommodityClassificationModel *)itemModel {
    _itemModel = itemModel;
    self.nameTextField.text = itemModel.classifyName;
    self.numberTextField.text = itemModel.classifyTotalCount;
}

@end
