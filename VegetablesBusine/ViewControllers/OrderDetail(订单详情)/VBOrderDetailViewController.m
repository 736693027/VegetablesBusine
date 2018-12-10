//
//  VBOrderDetailViewController.m
//  VegetablesBusine
//
//  Created by 刘少轩 on 2018/5/21.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "VBOrderDetailViewController.h"
#import "VMOrderTotalTableViewCell.h"
#import "VMOrderDetailTableViewCell.h"
#import "VBOrderDetailOrderStateTableViewCell.h"
#import "VBOrderDetailOrderOwnerTableViewCell.h"
#import "VBOrderDetailInformationTableViewCell.h"
#import <MJRefresh/MJRefresh.h>
#import "VMSectionHeaderView.h"
#import <Masonry/Masonry.h>
#import "VBGetDetailByIDRequest.h"
#import "VBProcessRefundRequest.h"
#import "VBProcessOrderRequest.h"
#import "VBWaitDealListModel.h"
#import <UITableView_FDTemplateLayoutCell/UITableView+FDTemplateLayoutCell.h>
#import "VBPrintOrderRequest.h"

@interface VBOrderDetailViewController ()
@property (weak, nonatomic) IBOutlet UIButton *cancleButton;
@property (weak, nonatomic) IBOutlet UIButton *printButton;
@property (weak, nonatomic) IBOutlet UIButton *acceptOrderButton;
@property (strong, nonatomic) VBWaitDealListModel *itemModel;
@end

@implementation VBOrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单详情";
    self.cancleButton.layer.borderColor = [CommonTools changeColor:@"0x666666"].CGColor;
    self.cancleButton.layer.borderWidth = 0.5f;
    self.printButton.layer.borderColor = [CommonTools changeColor:@"0x25ca86"].CGColor;
    self.printButton.layer.borderWidth = 0.5;
    self.printButton.layer.cornerRadius = 3;
    self.acceptOrderButton.layer.cornerRadius = 3;
    self.cancleButton.layer.cornerRadius = 3;
    
    [self creatTableViewViewTableViewStyle:UITableViewStyleGrouped];
    self.dataTableView.mj_header = nil;
    self.dataTableView.mj_footer = nil;
    self.dataTableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.0001)];
    self.dataTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.dataTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.offset(0);
        make.bottom.offset(-68);
    }];
    
    NSString *totalTableViewCell = NSStringFromClass([VMOrderTotalTableViewCell class]);
    NSString *orderDetailTableViewCell = NSStringFromClass([VMOrderDetailTableViewCell class]);
    NSString *orderStateTableViewCell = NSStringFromClass([VBOrderDetailOrderStateTableViewCell class]);
    NSString *orderOwnerTableViewCell = NSStringFromClass([VBOrderDetailOrderOwnerTableViewCell class]);
    NSString *informationTableViewCell = NSStringFromClass([VBOrderDetailInformationTableViewCell class]);
    [self tableRegisterNibName:totalTableViewCell cellReuseIdentifier:totalTableViewCell estimatedRowHeight:165];
    
    [self tableRegisterNibName:orderDetailTableViewCell cellReuseIdentifier:orderDetailTableViewCell estimatedRowHeight:81];
    
    [self tableRegisterNibName:orderStateTableViewCell cellReuseIdentifier:orderStateTableViewCell estimatedRowHeight:108];
    
    [self tableRegisterNibName:orderOwnerTableViewCell cellReuseIdentifier:orderOwnerTableViewCell estimatedRowHeight:110];
    
    [self tableRegisterNibName:informationTableViewCell cellReuseIdentifier:informationTableViewCell estimatedRowHeight:185];
    
    [self setBottomButtonStyle];
    
    [self requestListData];
}

#pragma mark 网络请求

- (void)requestListData {
    @weakify(self)
    VBGetDetailByIDRequest *requestData = [[VBGetDetailByIDRequest alloc] initWithIdString:@"12"];
    [requestData startRequestWithDicSuccess:^(NSDictionary *responseDic) {
        @strongify(self)
        self.itemModel = [VBWaitDealListModel yy_modelWithJSON:responseDic];
        [self.dataTableView reloadData];
    } failModel:^(LBResponseModel *errorModel) {
        [SVProgressHUD showErrorWithStatus:errorModel.message];
    } fail:^(YTKBaseRequest *request) {
        [SVProgressHUD showErrorWithStatus:@"订单详情获取失败"];
    }];
}
#pragma mark tableview datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0||section == 1||section == 3){
        return 1;
    }
    if(!self.itemModel.isCloselistData){
        return self.itemModel.listData.count+1;
    }else{
        return 1;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        VBOrderDetailOrderStateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VBOrderDetailOrderStateTableViewCell"];
        cell.itemModel = self.itemModel;
        return cell;
    }else if(indexPath.section == 1){
        VBOrderDetailOrderOwnerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VBOrderDetailOrderOwnerTableViewCell"];
        cell.itemModel = self.itemModel;
        cell.viewControl = self;
        return cell;
    }else if (indexPath.section == 2){
        if(indexPath.row==self.itemModel.listData.count||self.itemModel.isCloselistData){
            VMOrderTotalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VMOrderTotalTableViewCell"];
            cell.itemModel = self.itemModel;
            return cell;
        }else{
            VMOrderDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VMOrderDetailTableViewCell"];
            cell.itemModel = self.itemModel.listData[indexPath.row];
            return cell;
        }
    }else{
        VBOrderDetailInformationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VBOrderDetailInformationTableViewCell"];
        cell.itemModel = self.itemModel;
        return cell;
    }
}

#pragma mark tableview delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    @weakify(self)
    if(indexPath.section == 0){
        return [tableView fd_heightForCellWithIdentifier:@"VBOrderDetailOrderStateTableViewCell" configuration:^(VBOrderDetailOrderStateTableViewCell *cell) {
            @strongify(self)
            cell.itemModel = self.itemModel;
        }];
    }else if (indexPath.section == 1){
        return [tableView fd_heightForCellWithIdentifier:@"VBOrderDetailOrderOwnerTableViewCell" configuration:^(VBOrderDetailOrderOwnerTableViewCell *cell) {
            @strongify(self)
            cell.itemModel = self.itemModel;
        }];
    }else if (indexPath.section == 2){
        if(indexPath.row == self.itemModel.listData.count||self.itemModel.isCloselistData){
            return [tableView fd_heightForCellWithIdentifier:@"VMOrderTotalTableViewCell" configuration:^(VMOrderTotalTableViewCell *cell) {
                @strongify(self)
                cell.itemModel = self.itemModel;
            }];
        }else{
            return [tableView fd_heightForCellWithIdentifier:@"VMOrderDetailTableViewCell" configuration:^(VMOrderDetailTableViewCell *cell) {
                @strongify(self)
                cell.itemModel = self.itemModel.listData[indexPath.row];
            }];
        }
    }else{
        return [tableView fd_heightForCellWithIdentifier:@"VBOrderDetailInformationTableViewCell" configuration:^(VBOrderDetailInformationTableViewCell *cell) {
            @strongify(self)
            cell.itemModel = self.itemModel;
        }];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0001f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section == 2){
        return 60;
    }
    return 10.f;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if(section == 2){
        VMSectionHeaderView *headerView = [[[NSBundle mainBundle] loadNibNamed:@"VMSectionHeaderView" owner:self options:nil] lastObject];
        headerView.isCloseListData = self.itemModel.isCloselistData;
        headerView.updataHeadViewSubject = [RACSubject subject];
        @weakify(self)
        [headerView.updataHeadViewSubject subscribeNext:^(id  _Nullable x) {
            @strongify(self)
           self.itemModel.isCloselistData = !self.itemModel.isCloselistData;
            [self.dataTableView reloadSection:2 withRowAnimation:(UITableViewRowAnimationNone)];
        }];
        headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 60);
        return headerView;
    }
    return [UIView new];
}

#pragma mark 设置底部按钮

- (void)setBottomButtonStyle{
    switch (self.orderType) {
        case 1:
        {
            __weak typeof(self) weakSelf = self;
            [self.acceptOrderButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(weakSelf.view.mas_centerX);
                make.bottom.offset(-10);
                make.top.offset(10);
                make.width.offset(SCREEN_WIDTH*0.6);
            }];
            CGFloat buttonWidth = (SCREEN_WIDTH - 20 - 20 - SCREEN_WIDTH*0.6)/2;
            [self.cancleButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.left.offset(10);
                make.bottom.offset(-10);
                make.width.offset(buttonWidth);
            }];
            [self.printButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.offset(10);
                make.right.bottom.offset(-10);
                make.width.offset(buttonWidth);
            }];
        }
            break;
        case 2:{
            self.printButton.hidden = YES;
            CGFloat buttonWidth = (SCREEN_WIDTH - 30)/2;
            [self.acceptOrderButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.right.offset(-10);
                make.top.offset(10);
                make.width.offset(buttonWidth);
            }];
            [self.cancleButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.left.offset(10);
                make.bottom.offset(-10);
                make.width.offset(buttonWidth);
            }];
        }
            break;
            
        case 3:{
            self.cancleButton.hidden = YES;
            self.acceptOrderButton.hidden = YES;
            [self.printButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.top.offset(10);
                make.right.bottom.offset(-10);
            }];
            [self.printButton setTitle:@"打印订单" forState:UIControlStateNormal];
        }
            break;
        default:
            break;
    }
}
- (IBAction)refuseButtonClick:(id)sender {
    switch (self.orderType) {
        case 1:
        {
            [SVProgressHUD show];
            VBProcessOrderRequest *processOrderRequest = [[VBProcessOrderRequest alloc] initWithIdString:self.orderIdString type:2];
            @weakify(self)
            [processOrderRequest startRequestWithDicSuccess:^(NSDictionary *responseDic) {
                [SVProgressHUD showInfoWithStatus:@"拒绝成功"];
                @strongify(self)
                if(self.uploadDataSource){
                    [self.uploadDataSource sendNext:@""];
                }
                [self.navigationController popViewControllerAnimated:YES];
            } failModel:^(LBResponseModel *errorModel) {
                [SVProgressHUD showErrorWithStatus:errorModel.message];
            } fail:^(YTKBaseRequest *request) {
                [SVProgressHUD showErrorWithStatus:@"拒绝失败"];
            }];
        }
            break;
        case 2:
        {
            [SVProgressHUD show];
            VBProcessRefundRequest *processOrderRequest = [[VBProcessRefundRequest alloc] initWithIdString:self.orderIdString type:2];
            @weakify(self)
            [processOrderRequest startRequestWithDicSuccess:^(NSDictionary *responseDic) {
                [SVProgressHUD showInfoWithStatus:@"拒绝成功"];
                @strongify(self)
                if(self.uploadDataSource){
                    [self.uploadDataSource sendNext:@""];
                }
                [self.navigationController popViewControllerAnimated:YES];
            } failModel:^(LBResponseModel *errorModel) {
                [SVProgressHUD showErrorWithStatus:errorModel.message];
            } fail:^(YTKBaseRequest *request) {
                [SVProgressHUD showErrorWithStatus:@"拒绝失败"];
            }];
        }
            break;
            
        default:
            break;
    }
}
- (IBAction)acceptButtonClick:(id)sender {
    switch (self.orderType) {
        case 1:
        {
            [SVProgressHUD show];
            VBProcessOrderRequest *processOrderRequest = [[VBProcessOrderRequest alloc] initWithIdString:self.orderIdString type:1];
            @weakify(self)
            [processOrderRequest startRequestWithDicSuccess:^(NSDictionary *responseDic) {
                [SVProgressHUD showInfoWithStatus:@"抢单成功"];
                @strongify(self)
                if(self.uploadDataSource){
                    [self.uploadDataSource sendNext:@""];
                }
                [self.navigationController popViewControllerAnimated:YES];
            } failModel:^(LBResponseModel *errorModel) {
                [SVProgressHUD showErrorWithStatus:errorModel.message];
            } fail:^(YTKBaseRequest *request) {
                [SVProgressHUD showErrorWithStatus:@"抢单失败"];
            }];
        }
            break;
        case 2:
        {
            [SVProgressHUD show];
            VBProcessRefundRequest *processOrderRequest = [[VBProcessRefundRequest alloc] initWithIdString:self.orderIdString type:1];
            @weakify(self)
            [processOrderRequest startRequestWithDicSuccess:^(NSDictionary *responseDic) {
                [SVProgressHUD showInfoWithStatus:@"退款成功"];
                @strongify(self)
                if(self.uploadDataSource){
                    [self.uploadDataSource sendNext:@""];
                }
                [self.navigationController popViewControllerAnimated:YES];
            } failModel:^(LBResponseModel *errorModel) {
                [SVProgressHUD showErrorWithStatus:errorModel.message];
            } fail:^(YTKBaseRequest *request) {
                [SVProgressHUD showErrorWithStatus:@"退款失败"];
            }];
        }
            break;
            
        default:
            break;
    }
}
- (IBAction)printOrderButtonClick:(id)sender {
    VBPrintOrderRequest *printOrderRequest = [[VBPrintOrderRequest alloc] initWithIdString:@"12"];
    [printOrderRequest startRequestWithDicSuccess:^(NSDictionary *responseDic) {
        [SVProgressHUD showInfoWithStatus:@"打印成功"];
        if(self.uploadDataSource){
            [self.uploadDataSource sendNext:@""];
        }
        [self.navigationController popViewControllerAnimated:YES];
    } failModel:^(LBResponseModel *errorModel) {
        [SVProgressHUD showErrorWithStatus:errorModel.message];
    } fail:^(YTKBaseRequest *request) {
        [SVProgressHUD showErrorWithStatus:@"订单生成失败"];
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
