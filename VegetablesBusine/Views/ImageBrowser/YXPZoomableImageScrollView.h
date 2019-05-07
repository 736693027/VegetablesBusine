//
//  YXPZoomableImageScrollView.h
//  YXPSeller-iPhone
//
//  Created by zhaojunwei on 1/12/15.
//  Copyright (c) 2015 youxinpai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDWebImageOperation.h"
#import "YXPImageBrowserConstants.h"

@class YXPImageBrowserViewController;
@interface YXPZoomableImageScrollView : UIScrollView

@property (nonatomic, weak) YXPImageBrowserViewController *imageBrowser;
@property (nonatomic, retain) UIImageView *imageView;
@property (nonatomic, weak) id <SDWebImageOperation> webImageOperation;
@property (nonatomic, retain) UIProgressView *progressView;
@property (nonatomic, assign) BOOL isLoaded;
@property (nonatomic, copy) void(^damagePointHandler)(void);

//typedef void (^successBlock)(UIImage *image);
@property (nonatomic, copy) void (^successBlock)(UIImage *image);

- (void)configImageByURL:(NSURL *)url
        inCollectionView:(UICollectionView *)collectionView
             atIndexPath:(NSIndexPath *)indexPath success:(void (^)(UIImage *image))success;

- (void)configImageByImage:(UIImage *)image
          inCollectionView:(UICollectionView *)collectionView
               atIndexPath:(NSIndexPath *)indexPath success:(void (^)(UIImage *image))success;

@property (nonatomic, strong) UIImage *downImage;
@end
