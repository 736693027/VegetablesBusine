//
//  VBRefundTableViewCell.h
//  VegetablesBusine
//
//  Created by Apple on 2018/5/8.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class VBWaitDealListModel,RACSubject;

@interface VBRefundTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *commodityListView;
@property (weak, nonatomic) IBOutlet UIButton *refusedButton;
@property (weak, nonatomic) IBOutlet UILabel *orderTotalAmountLabel;
@property (weak, nonatomic) IBOutlet UIButton *orderButton;
@property (weak, nonatomic) IBOutlet UIView *mainContentView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *commodityListViewHeight;

@property (weak, nonatomic) IBOutlet UILabel *orderTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderOwnerLabel;
@property (weak, nonatomic) IBOutlet UILabel *creatOrderLabel;
@property (weak, nonatomic) IBOutlet UILabel *telLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalPriceLabel;
@property (weak, nonatomic) IBOutlet UIButton *listCloseButton;
@property (weak, nonatomic) IBOutlet UILabel *servicePriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderTotalLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderTotalProjectedRevenueLabel;

@property (strong, nonatomic) RACSubject *uploadCellState; //展示和关闭商品清单
@property (strong, nonatomic) RACSubject *uploadDataSource; //展示和关闭商品清单


@property (strong, nonatomic) VBWaitDealListModel *itemModel;
@end
