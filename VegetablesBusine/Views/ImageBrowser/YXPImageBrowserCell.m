//
//  YXPImageBrowserCell.m
//  YXPSeller-iPhone
//
//  Created by zhaojunwei on 1/12/15.
//  Copyright (c) 2015 youxinpai. All rights reserved.
//

#import "YXPImageBrowserCell.h"
#import "YXPImageBrowserViewController.h"
#import "YXPZoomableImageScrollView.h"
#import "STAlbumManager.h"
#import <Photos/Photos.h>


@implementation YXPImageBrowserCell{
    UIButton *SaveButton;
}

#pragma mark - Public

- (void)configCellImageObj:(id)obj
          inCollectionView:(UICollectionView *)collectionView
               atIndexPath:(NSIndexPath *)indexPath {
    SaveButton.hidden = !self.isShowSaveImageButton;
    self.zoomableImageScrollView.imageBrowser = self.imageBrowser;
    
    if ([obj isKindOfClass:[NSURL class]]){
        [self.zoomableImageScrollView configImageByURL:obj
                                      inCollectionView:collectionView
                                           atIndexPath:indexPath success:^(UIImage *image) {
                                               SaveButton.enabled = YES;
                                           }];
    }else if ([obj isKindOfClass:[NSString class]]){
        [self.zoomableImageScrollView configImageByURL:[NSURL URLWithString:obj]
                                      inCollectionView:collectionView
                                           atIndexPath:indexPath success:^(UIImage *image) {
                                               SaveButton.enabled = YES;
                                           }];
    }else{
        [self.zoomableImageScrollView configImageByImage:obj inCollectionView:collectionView atIndexPath:indexPath success:^(UIImage *image) {
            SaveButton.enabled = YES;
        }];
        
    }
}

- (UIImage *)getDownImage{
    return self.zoomableImageScrollView.imageView.image;
}

#pragma mark - Reuse

- (void)prepareForReuse {
    [super prepareForReuse];
    
    self.backgroundColor = [UIColor clearColor];
    
    // re create zoomableISV (for SDWebImage)
    [self.zoomableImageScrollView removeFromSuperview];
    self.zoomableImageScrollView = nil;
    
    self.zoomableImageScrollView = [[YXPZoomableImageScrollView alloc] init];
    self.zoomableImageScrollView.frame = CGRectMake(0.0f,
                                                    0.0f,
                                                    self.bounds.size.width,
                                                    self.bounds.size.height);
    
    self.zoomableImageScrollView.autoresizingMask =
    UIViewAutoresizingFlexibleWidth
    |UIViewAutoresizingFlexibleHeight;
    
    [self.contentView addSubview:self.zoomableImageScrollView];
    
    SaveButton.enabled = NO;
}

#pragma mark - Init

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor clearColor];
        
        self.autoresizingMask =
        UIViewAutoresizingFlexibleWidth
        |UIViewAutoresizingFlexibleHeight;
        
        self.contentView.autoresizingMask =
        UIViewAutoresizingFlexibleWidth
        |UIViewAutoresizingFlexibleHeight;
        
        self.zoomableImageScrollView = [[YXPZoomableImageScrollView alloc] init];
        self.zoomableImageScrollView.frame = CGRectMake(0.0f,
                                                        0.0f,
                                                        self.bounds.size.width,
                                                        self.bounds.size.height);
        
        self.zoomableImageScrollView.autoresizingMask =
        UIViewAutoresizingFlexibleWidth
        |UIViewAutoresizingFlexibleHeight;
        
        self.zoomableImageScrollView.imageBrowser = self.imageBrowser;
        
        [self.contentView addSubview:self.zoomableImageScrollView];
        
        SaveButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        UIImage *saveImage = [UIImage imageNamed:@"YXPImage_download_icon"];
        CGRect frame =CGRectMake(SCREEN_WIDTH-saveImage.size.width-25, SCREEN_HEIGHT-saveImage.size.height-25,saveImage.size.width,saveImage.size.height);
        [SaveButton setFrame:frame];
        [SaveButton setImage:saveImage forState:UIControlStateNormal];
        SaveButton.enabled = NO;
        SaveButton.hidden = YES;
        [SaveButton addTarget:self action:@selector(SavebtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:SaveButton];
    }
    return self;
}

-(void)SavebtnPressed:(id)sender
{
    
    // PHPhotoLibrary_class will only be non-nil on iOS 8.x.x
    if (NSClassFromString(@"PHPhotoLibrary")) {
        
        PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
        if (status == PHAuthorizationStatusDenied) {
            
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"请在 设置—隐私—照片 中开启丰顺路宝买家App对照片的访问权限" message:nil delegate:nil  cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
            
        }else if (status == PHAuthorizationStatusRestricted){
            
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"家长控制,不允许访问" message:nil delegate:nil  cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
            
        }else if (status == PHAuthorizationStatusNotDetermined){
            
            [self saveImage:self.zoomableImageScrollView.imageView.image toAlbum:@"丰顺路宝"];
            
        }else if (status == PHAuthorizationStatusAuthorized){
            
            [self saveImage:self.zoomableImageScrollView.imageView.image toAlbum:@"丰顺路宝"];
            
        }
    }else{
        
        STImageWriteToPhotosAlbum(self.zoomableImageScrollView.imageView.image, @"丰顺路宝", ^(UIImage *image, NSError *error){
            
            if(error){
                if (error.code == ALAssetsLibraryAccessUserDeniedError) {
                    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"请在 设置—隐私—照片 中开启丰顺路宝买家App对照片的访问权限" message:nil delegate:nil  cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alertView show];
                }else if(error.code == ALAssetsLibraryWriteDiskSpaceError){
                    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"存储空间不足,请在 设置-通用-用量 选项中设置" message:nil delegate:nil  cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alertView show];
                }else {
                    [self showCustomTips:[UIImage imageNamed:[NSString stringWithFormat:@"savePhotoFail"]] andTitle:@"图片保存失败"];
                }
                
            }else {
                [self showCustomTips:[UIImage imageNamed:[NSString stringWithFormat:@"savePhotoSuccess"]] andTitle:@"图片保存成功"];
            }
        });
        
    }
}


/**
 *  返回相册
 */
- (PHAssetCollection *)collectionWithTitle:(NSString *)AlbumName{
    // 先获得之前创建过的相册
    PHFetchResult<PHAssetCollection *> *collectionResult = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    for (PHAssetCollection *collection in collectionResult) {
        if ([collection.localizedTitle isEqualToString:AlbumName]) {
            return collection;
        }
    }
    
    // 如果相册不存在,就创建新的相册(文件夹)
    __block NSString *collectionId = nil; // __block修改block外部的变量的值
    // 这个方法会在相册创建完毕后才会返回
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        // 新建一个PHAssertCollectionChangeRequest对象, 用来创建一个新的相册
        collectionId = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:AlbumName].placeholderForCreatedAssetCollection.localIdentifier;
    } error:nil];
    
    return [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[collectionId] options:nil].firstObject;
}


/**
 *  返回相册,避免重复创建相册引起不必要的错误
 */
- (void)saveImage: (UIImage *)image toAlbum:(NSString *)AlbumName{
    __weak typeof(self) weakSelf = self;
    
    /*
     PHAsset : 一个PHAsset对象就代表一个资源文件,比如一张图片
     PHAssetCollection : 一个PHAssetCollection对象就代表一个相册
     */
    
    __block NSString *assetId = nil;
    // 1. 存储图片到"相机胶卷"
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{ // 这个block里保存一些"修改"性质的代码
        // 新建一个PHAssetCreationRequest对象, 保存图片到"相机胶卷"
        // 返回PHAsset(图片)的字符串标识
        assetId = [PHAssetCreationRequest creationRequestForAssetFromImage:image].placeholderForCreatedAsset.localIdentifier;
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        if (error) {
            dispatch_sync(dispatch_get_main_queue(), ^(){
                // 这里的代码会在主线程执行
                [weakSelf showCustomTips:[UIImage imageNamed:[NSString stringWithFormat:@"savePhotoFail"]] andTitle:@"图片保存失败"];
            });
            return;
        }
        
        // 2. 获得相册对象
        PHAssetCollection *collection = [self collectionWithTitle:AlbumName];
        
        // 3. 将“相机胶卷”中的图片添加到新的相册
        [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
            PHAssetCollectionChangeRequest *request = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:collection];
        
            // 根据唯一标示获得相片对象
            PHAsset *asset = [PHAsset fetchAssetsWithLocalIdentifiers:@[assetId] options:nil].firstObject;
            // 添加图片到相册中
            if(asset != nil)
            {
                [request addAssets:@[asset]];
            }
            else{
                dispatch_sync(dispatch_get_main_queue(), ^(){
                    // 这里的代码会在主线程执行
                    [weakSelf showCustomTips:[UIImage imageNamed:[NSString stringWithFormat:@"savePhotoFail"]] andTitle:@"图片保存失败"];
                });
                return;
            }
        } completionHandler:^(BOOL success, NSError * _Nullable error) {
            if (error) {
                dispatch_sync(dispatch_get_main_queue(), ^(){
                    // 这里的代码会在主线程执行
                    [weakSelf showCustomTips:[UIImage imageNamed:[NSString stringWithFormat:@"savePhotoFail"]] andTitle:@"图片保存失败"];
                });
                return;
            }
            
            //[[NSOperationQueue mainQueue] addOperationWithBlock:^{
            //    [SVProgressHUD showSuccessWithStatus:@"保存成功"];
            //}];
            
            dispatch_sync(dispatch_get_main_queue(), ^(){
                // 这里的代码会在主线程执行
                [weakSelf showCustomTips:[UIImage imageNamed:[NSString stringWithFormat:@"savePhotoSuccess"]] andTitle:@"图片保存成功"];
            });
        }];
    }];
}

- (void) showCustomTips:(UIImage *)image andTitle:(NSString *)title{
    [SVProgressHUD showImage:image status:title];
}

@end
