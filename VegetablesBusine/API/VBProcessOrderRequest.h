//
//  VBProcessOrderRequest.h
//  VegetablesBusine
//
//  Created by Apple on 2018/11/26.
//  Copyright © 2018 Apple. All rights reserved.
//

#import "LBBaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface VBProcessOrderRequest : LBBaseRequest

- (instancetype)initWithIdString:(NSString *)idString type:(NSInteger)type;

@end

NS_ASSUME_NONNULL_END
