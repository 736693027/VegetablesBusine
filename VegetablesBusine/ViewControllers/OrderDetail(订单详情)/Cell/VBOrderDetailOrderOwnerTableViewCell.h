//
//  VBOrderDetailOrderOwnerTableViewCell.h
//  VegetablesBusine
//
//  Created by Apple on 2018/5/24.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class VBWaitDealListModel;

@interface VBOrderDetailOrderOwnerTableViewCell : UITableViewCell

@property (strong, nonatomic) VBWaitDealListModel *itemModel;

@property (weak, nonatomic) UIViewController *viewControl;

@end
