//
//  VBShopIntroductionViewController.h
//  VegetablesBusine
//
//  Created by Apple on 2018/6/10.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "BaseViewController.h"
@class RACSubject;

@interface VBShopIntroductionViewController : BaseViewController

@property (copy, nonatomic) NSString *contentString;

@property (strong, nonatomic) RACSubject *textViewSubject;

@end
