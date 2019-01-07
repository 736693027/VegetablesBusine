//
//  VBGoodsUnitViewController.h
//  VegetablesBusine
//
//  Created by 刘少轩 on 2018/7/1.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "BaseViewController.h"

@interface VBGoodsUnitViewController : BaseViewController
@property (nonatomic,copy)void(^selectItemBlock)(NSString *, NSString *);
@end


@interface VBGoodsUnitModel: NSObject
@property (copy ,nonatomic) NSString *unitId;
@property (copy ,nonatomic) NSString *unitName;
@end
