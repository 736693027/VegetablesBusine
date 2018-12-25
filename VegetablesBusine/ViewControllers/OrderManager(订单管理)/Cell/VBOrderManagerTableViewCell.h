//
//  VBOrderManagerTableViewCell.h
//  VegetablesBusine
//
//  Created by Apple on 2018/5/8.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VBOrderManagerEnumHeaderFile.h"
@class VBWaitDealListModel;

@interface VBOrderManagerTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *commodityListView;
@property (weak, nonatomic) IBOutlet UILabel *orderTotalAmountLabel;
@property (weak, nonatomic) IBOutlet UIView *mainContentView;
@property (weak, nonatomic) IBOutlet UILabel *orderTitleLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *commodityListViewHeight;
@property (weak, nonatomic) IBOutlet UILabel *orderOwnerLabel;
@property (weak, nonatomic) IBOutlet UILabel *creatOrderLabel;
@property (weak, nonatomic) IBOutlet UILabel *telLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalPriceLabel;
@property (weak, nonatomic) IBOutlet UIButton *listCloseButton;
@property (weak, nonatomic) IBOutlet UILabel *servicePriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderTotalLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderTotalProjectedRevenueLabel;


@property (nonatomic) VBOrderManagerTableViewStyle cellType;
@property (strong, nonatomic) VBWaitDealListModel *itemModel;

@end
