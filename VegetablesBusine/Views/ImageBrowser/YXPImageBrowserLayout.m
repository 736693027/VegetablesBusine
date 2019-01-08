//
//  YXPImageBrowserLayout.m
//  YXPSeller-iPhone
//
//  Created by zhaojunwei on 1/12/15.
//  Copyright (c) 2015 youxinpai. All rights reserved.
//

#import "YXPImageBrowserLayout.h"
#import "YXPImageBrowserConstants.h"

@implementation YXPImageBrowserLayout

- (id)initWithItemSize:(CGSize)size {
    self = [super init];
    if (self) {
        // Initialization code
        self.itemSize = size;
        
        self.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
        self.minimumInteritemSpacing = 0.0f;
        self.minimumLineSpacing = YXPIB_PageGap;
        
        self.sectionInset = UIEdgeInsetsZero;
        self.footerReferenceSize = CGSizeZero;
        self.headerReferenceSize = CGSizeZero;
        
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return self;
}

- (CGSize)collectionViewContentSize {
    // re calculate content size for last one's gap
    NSInteger itemCount = [self.collectionView numberOfItemsInSection:0];
    
    CGFloat contentSize_width = (self.itemSize.width + YXPIB_PageGap) * itemCount;
    CGSize contentSize = CGSizeMake(contentSize_width, self.itemSize.height);
    
    return contentSize;
}

@end
