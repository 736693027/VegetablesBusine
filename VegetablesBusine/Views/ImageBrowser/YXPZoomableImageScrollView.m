//
//  YXPZoomableImageScrollView.m
//  YXPSeller-iPhone
//
//  Created by zhaojunwei on 1/12/15.
//  Copyright (c) 2015 youxinpai. All rights reserved.
//

#import "YXPZoomableImageScrollView.h"
#import "YXPImageBrowserCell.h"
#import "YXPImageBrowserViewController.h"
#import "UIImageView+WebCache.h"

static NSString * const YXPIB_PathHead_FileString = @"file";
static NSString * const YXPIB_PathHead_HTTPString = @"http";
/** ZoomableImageScrollView can zoom to how much bigger than original image */
static CGFloat const YXPZISV_zoom_bigger = 1.618f;

@interface YXPZoomableImageScrollView()<UIScrollViewDelegate, UIGestureRecognizerDelegate>

@end

@implementation YXPZoomableImageScrollView

#pragma mark - Config Image

- (void)configImageByURL:(NSURL *)url
        inCollectionView:(UICollectionView *)collectionView
             atIndexPath:(NSIndexPath *)indexPath success:(void (^)(UIImage *image))success{
    //NSLog(@"%@", url);
    self.successBlock = success;
    
    CGPoint centerPoint = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
    
    // check local or network
    if([[url absoluteString] length]==0){
        UIImage *errorImage = [UIImage imageNamed:@"placeholderCell_image"];
        self.imageView.image = errorImage;
        [self fitImageViewFrameByImageSize:self.imageView.image.size centerPoint:centerPoint];
        if (self.damagePointHandler) {
            self.damagePointHandler();
        }
    }else{
        NSString *pathHead = [[url absoluteString] substringToIndex:4];
        if ([pathHead isEqualToString:YXPIB_PathHead_FileString]) {
            NSData *data = [NSData dataWithContentsOfURL:url];
            UIImage *image = [UIImage imageWithData:data];
            if (image) {
                self.imageView.image = image;
            } else {
                UIImage *errorImage = [UIImage imageNamed:@"placeholderCell_image"];
                self.imageView.image = errorImage;
            }
            [self fitImageViewFrameByImageSize:self.imageView.image.size centerPoint:centerPoint];
            if (self.damagePointHandler) {
                self.damagePointHandler();
            }
            
        } else if ([[pathHead lowercaseString] isEqualToString:YXPIB_PathHead_HTTPString]) {
            BOOL shouldSet = NO;
            
            // download image request maybe calls by current cell
            // or next or prev by scrolling
            //        if (ABS(indexPath.item - self.imageBrowser.currentPage) == 1
            //            || (indexPath.item - self.imageBrowser.currentPage) == 0) {
            shouldSet = YES;
            //        }
            
            // not working for first show
            /**
             for (ACImageBrowserCell *cell in [collectionView visibleCells]) {
             NSIndexPath *cellIndexPath = [collectionView indexPathForCell:cell];
             if (ABS(indexPath.item - cellIndexPath.item) == 1
             || (indexPath.item - cellIndexPath.item) == 0) {
             shouldSet = YES;
             }
             }
             */
            UIImage *placeHolder = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]
                                                                     pathForResource:@"imageBrowserPlaceHolder.png" ofType:nil]];
            self.imageView.image = placeHolder;
            [self fitImageViewFrameByImageSize:self.imageView.image.size centerPoint:centerPoint];
            
            //        self.progressView.alpha = 1.0f;
            //        self.progressView.hidden = NO;
            
            __weak UIImageView *weakImageView = self.imageView;
            __weak UIProgressView *weakProgressView = self.progressView;
            
            self.webImageOperation = [[[SDWebImageManager sharedManager] imageDownloader] downloadImageWithURL:url options:SDWebImageRetryFailed | SDWebImageContinueInBackground progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
                if (shouldSet) {
                    weakProgressView.progress = ((float)receivedSize / expectedSize);
                }
            } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (shouldSet) {
                        weakProgressView.alpha = 0.0f;
                        weakProgressView.hidden = YES;
                        if (!error && finished && image) {
                            weakImageView.image = image;
                            //_downImage = image;
                            if(self.successBlock){
                                self.successBlock(image);
                            }
                        } else {
                            //                         UIImage *errorImage =
                            //                         [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]
                            //                                                           pathForResource:@"error_x" ofType:@"png"]];
                            //                         weakImageView.image = errorImage;
                        }
                        [self fitImageViewFrameByImageSize:weakImageView.image.size centerPoint:centerPoint];
                        if (self.damagePointHandler) {
                            self.damagePointHandler();
                        }
                        self.isLoaded = YES;
                    }
                });
            }];
            
//            self.webImageOperation =
//            [[SDWebImageManager sharedManager]
//             downloadImageWithURL:url
//             options:SDWebImageRetryFailed | SDWebImageContinueInBackground
//             progress:^(NSInteger receivedSize, NSInteger expectedSize) {
//                 if (shouldSet) {
//                     weakProgressView.progress = ((float)receivedSize / expectedSize);
//                 }
//             }
//             completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
//
//             }];
        }
    }
}

- (void)configImageByImage:(UIImage *)image
          inCollectionView:(UICollectionView *)collectionView
               atIndexPath:(NSIndexPath *)indexPath success:(void (^)(UIImage *image))success {
    
    self.successBlock = success;
    
    CGPoint centerPoint = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
    

    UIImage *placeHolder = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]
                                                             pathForResource:@"imageBrowserPlaceHolder.png" ofType:nil]];
    self.imageView.image = (image ? image: placeHolder);

    [self fitImageViewFrameByImageSize:self.imageView.image.size centerPoint:centerPoint];

}

#pragma mark - Calculate ImageView frame

- (void)fitImageViewFrameByImageSize:(CGSize)size centerPoint:(CGPoint)center {
    CGFloat imageWidth = size.width;
    CGFloat imageHeight = size.height;
    
    // zoom back first
    if (self.zoomScale != 1.0f) {
        [self zoomBackWithCenterPoint:center animated:NO];
    }
    
    CGFloat scale_max = 1.0f * YXPZISV_zoom_bigger;
    CGFloat scale_mini = 1.0f;
    
    self.maximumZoomScale = 1.0f * YXPZISV_zoom_bigger;
    self.minimumZoomScale = 1.0f;
    
    BOOL overWidth = imageWidth > self.bounds.size.width;
    BOOL overHeight = imageHeight > self.bounds.size.height;
    
    CGSize fitSize = CGSizeMake(imageWidth, imageHeight);
    
    if (overWidth && overHeight) {
        // fit by image width first if (height / times) still
        // bigger than self.bound.size.width
        // Then fit by height instead
        CGFloat timesThanScreenWidth = (imageWidth / self.bounds.size.width);
        
        if (!((imageHeight / timesThanScreenWidth) > self.bounds.size.height)) {
            scale_max =  timesThanScreenWidth * YXPZISV_zoom_bigger;
            fitSize.width = self.bounds.size.width;
            fitSize.height = imageHeight / timesThanScreenWidth;
        } else {
            CGFloat timesThanScreenHeight = (imageHeight / self.bounds.size.height);
            scale_max =  timesThanScreenHeight * YXPZISV_zoom_bigger;
            fitSize.width = imageWidth / timesThanScreenHeight;
            fitSize.height = self.bounds.size.height;
        }
    } else if (overWidth && !overHeight) {
        CGFloat timesThanFrameWidth = (imageWidth / self.bounds.size.width);
        scale_max =  timesThanFrameWidth * YXPZISV_zoom_bigger;
        fitSize.width = self.bounds.size.width;
        fitSize.height = imageHeight / timesThanFrameWidth;
    } else if (overHeight && !overWidth) {
        fitSize.height = self.bounds.size.height;
    }
    
    self.imageView.frame = CGRectMake((center.x - [UIScreen mainScreen].bounds.size.width / 2),
                                      (center.y - [UIScreen mainScreen].bounds.size.height / 2),
                                      [UIScreen mainScreen].bounds.size.width,
                                      [UIScreen mainScreen].bounds.size.height);
    
    self.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    
    self.maximumZoomScale = scale_max;
    self.minimumZoomScale = scale_mini;
}

#pragma mark - Init

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.zoomScale = 1.0f;
        self.bouncesZoom = YES;
        
        self.delegate = self;
        
        self.scrollEnabled = YES;
        
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        
        //self.alwaysBounceVertical = YES;
        
        self.backgroundColor = [UIColor clearColor];
        
        self.isLoaded = NO;
        
        [self createSubview];
    }
    return self;
}

- (void)createSubview {
    self.imageView = [[UIImageView alloc] init];
    
    self.imageView.autoresizingMask =
    UIViewAutoresizingFlexibleTopMargin
    | UIViewAutoresizingFlexibleRightMargin
    | UIViewAutoresizingFlexibleBottomMargin
    | UIViewAutoresizingFlexibleLeftMargin;
    
    self.imageView.backgroundColor = [UIColor clearColor];
    self.imageView.userInteractionEnabled = YES;
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    UITapGestureRecognizer * doubleTapGesture =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleTapGesture:)];
    doubleTapGesture.numberOfTouchesRequired = 1;
    doubleTapGesture.numberOfTapsRequired = 2;
    doubleTapGesture.delegate = self;
    [self.imageView addGestureRecognizer:doubleTapGesture];
    
    UITapGestureRecognizer * singleTapGesture =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleTapGesture:)];
    singleTapGesture.delegate= self;
    singleTapGesture.numberOfTouchesRequired = 1;
    singleTapGesture.numberOfTapsRequired = 1;
    [singleTapGesture requireGestureRecognizerToFail:doubleTapGesture];
    [self addGestureRecognizer:singleTapGesture];
    
    [self addSubview:self.imageView];
    
    //-- progress view
    self.progressView = [[UIProgressView alloc] init];
    
    self.progressView.autoresizingMask =
    UIViewAutoresizingFlexibleTopMargin
    | UIViewAutoresizingFlexibleRightMargin
    | UIViewAutoresizingFlexibleBottomMargin
    | UIViewAutoresizingFlexibleLeftMargin;
    
    self.progressView.userInteractionEnabled = NO;
    [self addSubview:self.progressView];
    self.progressView.alpha = 0.0f;
    self.progressView.hidden = YES;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // flag: image can't zoom by this
    //NSLog(@"layout size%@", NSStringFromCGSize(self.bounds.size));
    //CGPoint centerPoint = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
    //[self fitImageViewFrameByImageSize:self.imageView.image.size centerPoint:centerPoint];
    
    CGFloat progressView_margin = 36.0f;
    CGFloat progressView_w = self.bounds.size.width - progressView_margin * 2;
    CGFloat progressView_h = 2.0f;
    CGFloat progressView_x = progressView_margin;
    CGFloat progressView_y = (self.bounds.size.height - progressView_h) / 2;
    self.progressView.frame = CGRectMake(progressView_x,
                                         progressView_y,
                                         progressView_w,
                                         progressView_h);
}

#pragma mark - Scale

- (CGRect)zoomRectForScale:(CGFloat)scale withCenter:(CGPoint)center {
    CGRect zoomRect;
    
    // The zoom rect is in the content view's coordinates.
    // At a zoom scale of 1.0, it would be the size of the
    // imageScrollView's bounds.
    // As the zoom scale decreases, so more content is visible,
    // the size of the rect grows.
    zoomRect.size.height = self.frame.size.height / scale;
    zoomRect.size.width  = self.frame.size.width  / scale;
    
    // choose an origin so as to get the right center.
    zoomRect.origin.x    = center.x - (zoomRect.size.width  / 2);
    zoomRect.origin.y    = center.y - (zoomRect.size.height / 2);
    
    return zoomRect;
}

#pragma mark - UIScrollViewDelegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    CGFloat offsetX =
    (self.bounds.size.width > self.contentSize.width) ?
    (self.bounds.size.width - self.contentSize.width) * 0.5f : 0.0f;
    
    CGFloat offsetY =
    (self.bounds.size.height > self.contentSize.height)?
    (self.bounds.size.height - self.contentSize.height) * 0.5f : 0.0f;
    
    self.imageView.center = CGPointMake(self.contentSize.width * 0.5f + offsetX,
                                        self.contentSize.height * 0.5f + offsetY);
}

//- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale {
//    //NSLog(@"%f", scale);
//}

#pragma mark - Zoom Action

- (void)zoomBackWithCenterPoint:(CGPoint)center animated:(BOOL)animated {
    CGRect rect = [self zoomRectForScale:1.0f withCenter:center];
    [self zoomToRect:rect animated:animated];
}

- (void)handleTapGesture:(UITapGestureRecognizer *)tapGesture {
    if (tapGesture.numberOfTapsRequired == 2) {
        // don't know why some photo just can not zoom to maximumZoomScale
        BOOL range_left = self.zoomScale > (self.maximumZoomScale * 0.9f);
        BOOL range_right = self.zoomScale <= self.maximumZoomScale;
        
        if (range_left && range_right) {
            CGRect rect = [self zoomRectForScale:self.minimumZoomScale
                                      withCenter:[tapGesture locationInView:tapGesture.view]];
            [self zoomToRect:rect animated:YES];
        } else {
            CGRect rect = [self zoomRectForScale:self.maximumZoomScale
                                      withCenter:[tapGesture locationInView:tapGesture.view]];
            [self zoomToRect:rect animated:YES];
        }
    } else if (tapGesture.numberOfTapsRequired == 1) {
        [[NSNotificationCenter defaultCenter] postNotificationName:YXPIBU_SingleTapNotificationName
                                                                object:nil];
    }
}

@end
