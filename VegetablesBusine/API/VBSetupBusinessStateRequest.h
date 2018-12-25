//
//  VBSetupBusinessStateRequest.h
//  VegetablesBusine
//
//  Created by Apple on 2018/12/24.
//  Copyright © 2018 Apple. All rights reserved.
//

#import "VBSessionKeyBaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface VBSetupBusinessStateRequest : VBSessionKeyBaseRequest

- (instancetype)initWithBusinessState:(NSInteger)businessState;

@end

NS_ASSUME_NONNULL_END
