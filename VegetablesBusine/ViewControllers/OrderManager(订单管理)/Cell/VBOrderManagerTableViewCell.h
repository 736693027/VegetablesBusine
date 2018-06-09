//
//  VBOrderManagerTableViewCell.h
//  VegetablesBusine
//
//  Created by Apple on 2018/5/8.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VBOrderManagerEnumHeaderFile.h"

@interface VBOrderManagerTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *commodityListView;
@property (weak, nonatomic) IBOutlet UILabel *orderTotalAmountLabel;
@property (weak, nonatomic) IBOutlet UIView *mainContentView;
@property (weak, nonatomic) IBOutlet UILabel *orderTitleLabel;
@property (nonatomic) VBOrderManagerTableViewStyle cellType;
@end
