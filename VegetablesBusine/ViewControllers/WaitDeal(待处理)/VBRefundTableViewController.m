//
//  VBRefundTableViewController.m
//  VegetablesBusine
//
//  Created by Apple on 2018/5/8.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "VBRefundTableViewController.h"
#import <Masonry/Masonry.h>
#import <UITableView_FDTemplateLayoutCell/UITableView+FDTemplateLayoutCell.h>
#import "VBRefundTableViewCell.h"
#import "VBOrderDetailViewController.h"
#import "VBListDataRequest.h"
#import "VBWaitDealListModel.h"

@interface VBRefundTableViewController ()

@end

@implementation VBRefundTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatTableViewViewTableViewStyle:UITableViewStylePlain];
    [self.dataTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.left.offset(0);
        make.bottom.offset(0);
        make.width.offset(SCREEN_WIDTH);
    }];
    self.dataTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.dataTableView.backgroundColor = [CommonTools changeColor:@"0xECECEC"];
    NSString *cellClassName = NSStringFromClass([VBRefundTableViewCell class]);
    [self tableRegisterNibName:cellClassName cellReuseIdentifier:cellClassName estimatedRowHeight:503];
    
    UIView *tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 15)];
    tableFooterView.backgroundColor = [UIColor clearColor];
    self.dataTableView.tableFooterView = tableFooterView;
}
- (void)requestListData {
    [SVProgressHUD show];
    VBListDataRequest *dataRequest = [[VBListDataRequest alloc] initWithPage:1 rows:20 tag:self.tableTag requestType:(VBListDataRequestType)self.tableTag];
    [dataRequest startRequestWithArraySuccess:^(NSArray *responseArray) {
        [SVProgressHUD dismiss];
        if(self.currentPage == 1){
            [self.dataArray removeAllObjects];
        }
        [self.dataArray addObjectsFromArray:[NSArray yy_modelArrayWithClass:[VBWaitDealListModel class] json:responseArray]];
        [self.dataTableView reloadData];
    } failModel:^(LBResponseModel *errorModel) {
        [SVProgressHUD showErrorWithStatus:errorModel.message];
    } fail:^(YTKBaseRequest *request) {
        [SVProgressHUD showErrorWithStatus:@"获取失败"];
    }];
}
#pragma mark tableView datasource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    @weakify(self);
    return [tableView fd_heightForCellWithIdentifier:@"VBRefundTableViewCell" configuration:^(VBRefundTableViewCell *cell) {
        @strongify(self);
        VBWaitDealListModel *itemModel = [self.dataArray objectAtIndex:indexPath.row];
        cell.itemModel = itemModel;
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    VBRefundTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VBRefundTableViewCell"];
    VBWaitDealListModel *itemModel = [self.dataArray objectAtIndex:indexPath.row];
    cell.itemModel = itemModel;
    cell.uploadCellState = [RACSubject subject];
    @weakify(self)
    [cell.uploadCellState subscribeNext:^(id  _Nullable x) {
        [tableView beginUpdates];
        [tableView endUpdates];
    }];
    cell.uploadDataSource = [RACSubject subject];
    [cell.uploadDataSource subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [self requestListData];
    }];
    return cell;
}
#pragma mark tableview delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    VBOrderDetailViewController *detailVC = [[VBOrderDetailViewController alloc] init];
    detailVC.hidesBottomBarWhenPushed = YES;
    detailVC.orderType = VBOrderDetailTypeNewOrder;
    VBWaitDealListModel *itemModel = [self.dataArray objectAtIndex:indexPath.row];
    detailVC.orderIdString = itemModel.orderId;
    [self.navigationController pushViewController:detailVC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
@end
