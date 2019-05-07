//
//  YXPImageBrowserCell.h
//  YXPSeller-iPhone
//
//  Created by zhaojunwei on 1/12/15.
//  Copyright (c) 2015 youxinpai. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YXPImageBrowserViewController, YXPZoomableImageScrollView;
@interface YXPImageBrowserCell : UICollectionViewCell

@property (nonatomic, weak) YXPImageBrowserViewController *imageBrowser;
@property (nonatomic, strong) YXPZoomableImageScrollView *zoomableImageScrollView;
@property (nonatomic, assign) BOOL isShowSaveImageButton;

- (void)configCellImageObj:(id)obj
          inCollectionView:(UICollectionView *)collectionView
               atIndexPath:(NSIndexPath *)indexPath;

@end
