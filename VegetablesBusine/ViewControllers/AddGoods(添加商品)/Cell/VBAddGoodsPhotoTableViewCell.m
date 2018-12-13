//
//  VBAddGoodsPhotoTableViewCell.m
//  VegetablesBusine
//
//  Created by 刘少轩 on 2018/6/28.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "VBAddGoodsPhotoTableViewCell.h"
#import "VBAddGoodsInfoModel.h"
#import <SDWebImage/UIButton+WebCache.h>

@interface VBAddGoodsPhotoTableViewCell()
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UIButton *headImageButton;
@property (weak, nonatomic) IBOutlet UITextView *subTitleTextField;
@end

@implementation VBAddGoodsPhotoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.nameTextField addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
}
- (void)setItemModel:(VBAddGoodsInfoModel *)itemModel{
    _itemModel = itemModel;
    [self.headImageButton sd_setImageWithURL:[NSURL URLWithString:itemModel.imageUrl] forState:UIControlStateNormal placeholderImage:PlaceHolderImage];
    self.nameTextField.text = itemModel.name;
    self.subTitleTextField.text = itemModel.subtitle;
}
- (void)textFieldDidChanged:(UITextField *)textField{
    NSString *textString = textField.text;
    if(textString.length>10){
        textString = [textString substringToIndex:10];
    }
    textField.text = textString;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
