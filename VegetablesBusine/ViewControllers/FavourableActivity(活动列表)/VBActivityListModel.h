//
//  VBActivityListModel.h
//  VegetablesBusine
//
//  Created by Apple on 2018/12/25.
//  Copyright © 2018 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VBActivityListModel : NSObject

@property (assign, nonatomic) NSString *activeId;
@property (assign, nonatomic) NSString *title;
@property (assign, nonatomic) NSString *activeRuler;
@property (assign, nonatomic) NSString *activeDateTime;
@property (assign, nonatomic) NSString *activeState;
@property (assign, nonatomic) NSString *activeCreateTime;

@end

NS_ASSUME_NONNULL_END
