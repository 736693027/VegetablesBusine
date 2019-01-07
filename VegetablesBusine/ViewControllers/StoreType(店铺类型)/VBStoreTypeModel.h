//
//  VBStoreTypeModel.h
//  VegetablesBusine
//
//  Created by 刘少轩 on 2018/6/24.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VBStoreTypeModel : NSObject
@property (copy, nonatomic) NSString *typeName;
@property (copy, nonatomic) NSString *typeId;
@property (copy, nonatomic) NSString *sort;
@property (assign, nonatomic) BOOL isSelect;
@end
