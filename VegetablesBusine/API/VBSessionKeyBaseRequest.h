//
//  VBSessionKeyBaseRequest.h
//  VegetablesBusine
//
//  Created by Apple on 2018/12/11.
//  Copyright © 2018 Apple. All rights reserved.
//

#import "LBBaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface VBSessionKeyBaseRequest : LBBaseRequest

@property (copy, nonatomic) NSString *sessionKey;

@end

NS_ASSUME_NONNULL_END
