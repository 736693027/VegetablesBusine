//
//  VMCustomTabBar.m
//  VegetableManagement
//
//  Created by Apple on 2018/3/30.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "VMCustomTabBar.h"
#import "CustomerTabBarView.h"

@implementation VMCustomTabBar
- (instancetype)init{
    self = [super init];
    if(self){
        [self addSubview:self.tabBarView];
    }
    return self;
}

- (CustomerTabBarView *)tabBarView{
    if(_tabBarView == nil){
        _tabBarView = [[[NSBundle mainBundle] loadNibNamed:@"CustomerTabBarView" owner:self options:nil] lastObject];
    }
    return _tabBarView;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.tabBarView.frame = self.bounds;
//    CGRect frame = self.tabBarView.frame;
//    frame.size.height += 20;
//    self.tabBarView.frame = frame;
    [self bringSubviewToFront:self.tabBarView];
}
@end
