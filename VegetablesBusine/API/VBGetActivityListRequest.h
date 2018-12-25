//
//  VBGetActivityListRequest.h
//  VegetablesBusine
//
//  Created by Apple on 2018/12/25.
//  Copyright © 2018 Apple. All rights reserved.
//

#import "VBSessionKeyBaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface VBGetActivityListRequest : VBSessionKeyBaseRequest

- (instancetype)initWithCurrentPage:(NSInteger)currentPage tab:(NSInteger)tab;

@end

NS_ASSUME_NONNULL_END
