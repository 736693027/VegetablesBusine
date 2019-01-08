//
//  LBAbnormalLoginAlertView.h
//  LBBuyer
//
//  Created by demoker on 15/12/28.
//  Copyright © 2015年 Lubao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JCAlertView.h"

@interface LBAbnormalLoginAlertView : UIView
@property (copy, nonatomic) void(^reLogin)(id);
@property (copy, nonatomic) void(^exit)(id);
@property (assign, nonatomic) JCAlertView * delegate;
@end
