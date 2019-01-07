//
//  VBDeliveryInformationViewController.h
//  VegetablesBusine
//
//  Created by Apple on 2018/6/11.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "BaseViewController.h"

@interface VBDeliveryInformationViewController : BaseViewController
@property (nonatomic,copy)void(^callBack)(NSString *, NSArray *);
@property (nonatomic,strong)NSArray *selectArray;
@end
