//
//  YXPImageBrowserViewController.h
//  YXPSeller-iPhone
//
//  Created by zhaojunwei on 1/12/15.
//  Copyright (c) 2015 youxinpai. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YXPImageBrowserViewControllerDelegate <NSObject>

- (void)dismissAtIndex:(NSInteger)index;

@end

@interface YXPImageBrowserViewController : UIViewController

@property (nonatomic, assign) id<YXPImageBrowserViewControllerDelegate>delegate;

@property (nonatomic, copy) void (^didScrollToIndexBlock)(NSInteger index);

@property (nonatomic, assign, readonly) NSInteger currentIndex;

@property (nonatomic, assign) BOOL isShowDownLoadButton;

- (instancetype)initWithImageUrls:(NSArray <__kindof NSString *> *)imageUrls
                      imageTitles:(NSArray <__kindof NSString *>*)imageTitles;

- (instancetype)initWithImages:(NSArray <__kindof UIImage *>*)images
                   imageTitles:(NSArray <__kindof NSString *>*)imageTitles;

- (void)setPageIndex:(NSUInteger)index;

@end
