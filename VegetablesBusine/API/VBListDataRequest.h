//
//  VBListDataRequest.h
//  VegetablesBusine
//
//  Created by Apple on 2018/11/26.
//  Copyright © 2018 Apple. All rights reserved.
//

#import "LBBaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface VBListDataRequest : LBBaseRequest

- (instancetype)initWithPage:(NSInteger)page rows:(NSInteger)rows;

@end

NS_ASSUME_NONNULL_END
