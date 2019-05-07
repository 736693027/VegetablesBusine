//
//  VMSectionHeaderView.h
//  VegetableManagement
//
//  Created by Apple on 2018/4/12.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RACSubject;

@interface VMSectionHeaderView : UIView

@property (nonatomic) BOOL isCloseListData;

@property (strong, nonatomic) RACSubject *updataHeadViewSubject;

@end
