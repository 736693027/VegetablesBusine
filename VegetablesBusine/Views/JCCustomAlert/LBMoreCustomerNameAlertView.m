//
//  LBMoreCustomerNameAlertView.m
//  LBReport
//
//  Created by penzhk on 16/4/27.
//  Copyright © 2016年 FSLB. All rights reserved.
//

#import "LBMoreCustomerNameAlertView.h"
#import "LBGetCustomerModel.h"
#import "LBMoreCustomerNameCell.h"

@interface LBMoreCustomerNameAlertView ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation LBMoreCustomerNameAlertView

+ (instancetype)loadAlertViewWithTitle:(NSString *)title
                         customerArray:(NSMutableArray *)customerArray
                                  left:(void(^)(id))left
                                 right:(void(^)(id,id))right {
    
    LBMoreCustomerNameAlertView * alertView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([LBMoreCustomerNameAlertView class]) owner:self options:nil] lastObject];
    alertView.TitleLB.text = title;
    alertView.cancel = left;
    alertView.done = right;
    
    alertView.cancelBtn.layer.masksToBounds = YES;
    alertView.doneBtn.layer.masksToBounds = YES;
    
    [alertView.cancelBtn.layer setCornerRadius:3];
    [alertView.doneBtn.layer setCornerRadius:3];
    
    [alertView.cancelBtn.layer setBorderWidth:.5f];
    [alertView.doneBtn.layer setBorderWidth:.5f];
    
    UIColor *color = [CommonTools changeColor:@"0xdbdbdb"];
    [alertView.cancelBtn.layer setBorderColor:color.CGColor];
    [alertView.doneBtn.layer setBorderColor:color.CGColor];

    [alertView.cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [alertView.doneBtn setTitle:@"确认" forState:UIControlStateNormal];

    return alertView;
}

+ (instancetype)loadAlertViewWithTitle:(NSString *)title leftBtnTitle:(NSString *)lTitle rightTitle:(NSString*)rTitle CustomerArray:(NSMutableArray *)CustomerArray left:(void(^)(id))left right:(void(^)(id,id))right{
    LBMoreCustomerNameAlertView * alertView = [[[NSBundle mainBundle] loadNibNamed:@"LBMoreCustomerNameAlertView" owner:self options:nil] lastObject];
    alertView.TitleLB.text = title;
    //alertView.Customer = CustomerArray;
    alertView.cancel = left;
    alertView.done = right;
    
    alertView.cancelBtn.layer.masksToBounds = YES;
    alertView.doneBtn.layer.masksToBounds = YES;
    
    [alertView.cancelBtn.layer setCornerRadius:3];
    [alertView.doneBtn.layer setCornerRadius:3];
    
    [alertView.cancelBtn.layer setBorderWidth:.5f];
    [alertView.doneBtn.layer setBorderWidth:.5f];
    
    //CGColorRef color = CGColorCreate(CGColorSpaceCreateDeviceRGB(), (CGFloat[]){1,0,0,1});
    
    UIColor *color = [CommonTools changeColor:@"0xdbdbdb"];
    [alertView.cancelBtn.layer setBorderColor:color.CGColor];
    [alertView.doneBtn.layer setBorderColor:color.CGColor];
    
    //alertView.cancelBtn.backgroundColor = UIColorFromRGB(0x414141);
    //alertView.doneBtn.backgroundColor = UIColorFromRGB(0xff4d4d);
    
    [alertView.cancelBtn setTitle:lTitle forState:UIControlStateNormal];
    [alertView.doneBtn setTitle:rTitle forState:UIControlStateNormal];
    
    return alertView;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    
    self.layer.cornerRadius = 3;
    
    [_cancelBtn addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchDown];
    [_doneBtn addTarget:self action:@selector(doneAction:) forControlEvents:UIControlEventTouchDown];
    
    _mTableView.delegate = self;
    _mTableView.dataSource = self;
    
    UIView * view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [_mTableView setTableFooterView:view];
    
    //[self.mTableView reloadData];
}


- (void)cancelAction:(id)sender{
    
    if(self.cancel){
        self.cancel(self.delegate);
    }
}

- (void)doneAction:(id)sender{
    
    if(self.done){
        if(nil == self.selectcustomer){
            [SVProgressHUD showWithStatus:@"请选择会员名字"];
        }else{
            self.done(self.delegate, self.selectcustomer);}
    }
}

- (NSMutableArray *)Customer{
    if(!_Customer){
        _Customer = [[NSMutableArray alloc]init];
    }
    return _Customer;
}

#pragma mark - TableViewDatasource、delegate
//- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
//    return 1;
//}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.Customer.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"morecustomernamealertviewcell";
    LBMoreCustomerNameCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell){
        cell = [[[NSBundle mainBundle] loadNibNamed:@"LBMoreCustomerNameCell" owner:nil options:nil] lastObject];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    LBGetCustomerModel *customer = [self.Customer objectAtIndex:indexPath.row];
    cell.LoginNameLabel.text = [NSString stringWithFormat:@"%@ - %@",customer.vipName, customer.loginName];
   
    return cell;
    
}

//- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    return [NSString stringWithFormat:@"第%ld组",section];
//    
//   }

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.selectcustomer = [self.Customer objectAtIndex:indexPath.row];
}

@end
