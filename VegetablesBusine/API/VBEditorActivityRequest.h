//
//  VBEditorActivityRequest.h
//  VegetablesBusine
//
//  Created by Apple on 2018/12/25.
//  Copyright © 2018 Apple. All rights reserved.
//

#import "VBSessionKeyBaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface VBEditorActivityRequest : VBSessionKeyBaseRequest

- (instancetype)initWithActivityId:(NSString *)activityId;


@end

NS_ASSUME_NONNULL_END
