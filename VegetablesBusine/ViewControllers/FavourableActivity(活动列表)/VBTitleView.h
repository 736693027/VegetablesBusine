//
//  VBTitleView.h
//  VegetablesBusine
//
//  Created by Apple on 2018/6/26.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RACSubject;

@interface VBTitleView : UIView

@property (strong, nonatomic) RACSubject *selectIndexSubject;

@end
