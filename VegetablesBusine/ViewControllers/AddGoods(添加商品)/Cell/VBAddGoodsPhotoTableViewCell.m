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
#import "ACActionSheet.h"
#import "YXPImageBrowserViewController.h"
#import "MLSelectPhotoPickerViewController.h"
#import "MLSelectPhotoAssets.h"
#import "VMNavigationController.h"
#import "CommonTools.h"
#import "JCAlertView.h"

@interface VBAddGoodsPhotoTableViewCell()<UITextViewDelegate,ACActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UIButton *headImageButton;
@property (weak, nonatomic) IBOutlet UITextView *subTitleTextField;
@property (strong, nonatomic) UIImage *uploadImage;
@end

@implementation VBAddGoodsPhotoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.nameTextField addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
    _subTitleTextField.delegate = self;
}
- (void)setItemModel:(VBAddGoodsInfoModel *)itemModel{
    _itemModel = itemModel;
    if(itemModel.imageUrl){
        [self.headImageButton sd_setImageWithURL:[NSURL URLWithString:itemModel.imageUrl] forState:UIControlStateNormal placeholderImage:PlaceHolderImage];
    }
    self.nameTextField.text = itemModel.name;
    self.subTitleTextField.text = itemModel.subtitle;
}

- (void)textFieldDidChanged:(UITextField *)textField{
    NSString *textString = textField.text;
    if(textString.length>10){
        textString = [textString substringToIndex:10];
    }
    textField.text = textString;
    _itemModel.name = textString;
}
- (IBAction)addImageButtonClick:(UIButton *)sender {
//    if (!self.uploadImage&&!_itemModel.imageUrl){
    
        ACActionSheet * sheet = [[ACActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"从手机相册选择", nil];
        [sheet show];
        
//    }else{
//        YXPImageBrowserViewController * imageBrowserCtl;
//        if(self.uploadImage){
//            imageBrowserCtl = [[YXPImageBrowserViewController alloc] initWithImages:@[self.uploadImage] imageTitles:@[@""]];
//        }else if (self.itemModel.imageUrl){
//            imageBrowserCtl = [[YXPImageBrowserViewController alloc] initWithImageUrls:@[self.itemModel.imageUrl] imageTitles:@[@""]];
//        }
//        [imageBrowserCtl setPageIndex:0];
//        imageBrowserCtl.didScrollToIndexBlock = ^(NSInteger currentIndex) {
//
//        };
//        VMNavigationController *nav = [[VMNavigationController alloc] initWithRootViewController:imageBrowserCtl];
//        nav.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
//        nav.modalPresentationStyle = UIModalPresentationOverCurrentContext;
//        UIViewController *currentVC = self.viewController;
//        [currentVC presentViewController:nav animated:YES completion:nil];
//    }
}
#pragma mark - ACActionSheetDelegate

- (void)actionACSheet:(ACActionSheet *)actionSheet didClickedButtonAtIndex:(NSInteger)buttonIndex {
    
    switch (buttonIndex) {
        case 0:{
            //拍照
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            
            UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
            picker.delegate = self;
            picker.allowsEditing = NO;
            picker.sourceType = sourceType;
            [CommonTools allowCameraStateBlock:^(BOOL result) {
                if(result){
                    [self.viewController presentViewController:picker animated:YES completion:^{
                        
                    }];
                }else{
                    [JCAlertView showOneButtonWithTitle:@"相机调用失败" Message:@"请在通用-路宝助手-相机中允许使用相机功能" ButtonType:JCAlertViewButtonTypeCancel ButtonTitle:@"确定" Click:^{
                        
                    }];
                }
            }];
            
            break;
        }
        case 1:{
            //从手机相册选择
            MLSelectPhotoPickerViewController *pickerVc = [[MLSelectPhotoPickerViewController alloc] init];
            pickerVc.maxCount = 1;
            pickerVc.status = PickerViewShowStatusCameraRoll;
            [pickerVc showPickerVc:self.viewController];
            @weakify(self);
            pickerVc.callBack = ^(NSArray *assets){
                @strongify(self)
                if(assets.count == 0){
                    [SVProgressHUD showInfoWithStatus:@"请选择要上传的图片"];
                    return ;
                }
                for (NSInteger i=0; i<[assets count]; i++) {
                    MLSelectPhotoAssets *asset = assets[i];
                    self.uploadImage = [MLSelectPhotoPickerViewController getImageWithImageObj:asset];
                    [self.headImageButton setImage:self.uploadImage forState:UIControlStateNormal];
                    if(self.uploadNewImageSubject){
                        [self.uploadNewImageSubject sendNext:self.uploadImage];
                    }
                }
            };
            break;
        }
        case 2:{
            //取消
            
            break;
        }
            
        default:
            break;
    }
    
}
#pragma mark - UINavigationControllerDelegate, UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
    self.uploadImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self.headImageButton setImage:self.uploadImage forState:UIControlStateNormal];
    if(self.uploadNewImageSubject){
        [self.uploadNewImageSubject sendNext:self.uploadImage];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)textViewDidChange:(UITextView *)textView {
    _itemModel.subtitle = textView.text;
}

@end
