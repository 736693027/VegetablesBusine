//
//  VMGetBusinessStatisticsRequest.h
//  VegetablesBusine
//
//  Created by Apple on 2019/1/8.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "VBSessionKeyBaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface VMGetBusinessStatisticsRequest : VBSessionKeyBaseRequest

- (instancetype)initWithType:(NSInteger)type startTime:(NSString *)startTime endTime:(NSString *)endTime;

@end

NS_ASSUME_NONNULL_END
