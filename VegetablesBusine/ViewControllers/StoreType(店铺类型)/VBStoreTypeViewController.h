//
//  VBStoreTypeViewController.h
//  VegetablesBusine
//
//  Created by 刘少轩 on 2018/6/24.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "BaseViewController.h"

@interface VBStoreTypeViewController : BaseViewController
@property (nonatomic,copy)void(^selectItemBlock)(NSString *);
@property (nonatomic,copy)NSString *selectedTypeName;
@end
