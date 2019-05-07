//
//  LBMoreCustomerNameAlertView.h
//  LBReport
//
//  Created by penzhk on 16/4/27.
//  Copyright © 2016年 FSLB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LBGetCustomerModel.h"
#import "JCAlertView.h"

@interface LBMoreCustomerNameAlertView : UIView
@property (assign, nonatomic) JCAlertView * delegate;

@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UIButton *doneBtn;
@property (weak, nonatomic) IBOutlet UILabel *TitleLB;

@property (weak, nonatomic) IBOutlet UITableView *mTableView;
@property (copy, nonatomic) void(^cancel)(id sender);

@property (copy, nonatomic) void(^done)(id sender, LBGetCustomerModel *selectcustomer);

@property (retain, nonatomic) NSMutableArray *Customer;
@property (nonatomic, strong) LBGetCustomerModel *selectcustomer;


+ (instancetype)loadAlertViewWithTitle:(NSString *)title
                         customerArray:(NSMutableArray *)customerArray
                                  left:(void(^)(id))left
                                 right:(void(^)(id,id))right;

+ (instancetype)loadAlertViewWithTitle:(NSString *)title leftBtnTitle:(NSString *)lTitle rightTitle:(NSString*)rTitle CustomerArray:(NSMutableArray *)CustomerArray left:(void(^)(id))left right:(void(^)(id,id))right;

@end
