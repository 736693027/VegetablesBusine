//
//  VBWaitDealTableViewController.m
//  VegetablesBusine
//
//  Created by Apple on 2018/5/8.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "VBWaitDealTableViewController.h"
#import <Masonry/Masonry.h>
#import <UITableView_FDTemplateLayoutCell/UITableView+FDTemplateLayoutCell.h>
#import "VBWaitDealTableViewCell.h"
#import "VBOrderDetailViewController.h"
#import "VBListDataRequest.h"
#import "VBWaitDealListModel.h"

@interface VBWaitDealTableViewController ()

@end

@implementation VBWaitDealTableViewController

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
    NSString *cellClassName = NSStringFromClass([VBWaitDealTableViewCell class]);
    [self tableRegisterNibName:cellClassName cellReuseIdentifier:cellClassName estimatedRowHeight:503];
    
    UIView *tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 15)];
    tableFooterView.backgroundColor = [UIColor clearColor];
    self.dataTableView.tableFooterView = tableFooterView;
}
- (void)requestListData {
    [SVProgressHUD show];
    VBListDataRequest *dataRequest = [[VBListDataRequest alloc] initWithPage:1 rows:20 tag:self.tableTag requestType:(VBListDataRequestType)self.tableTag];
    [dataRequest startRequestWithDicSuccess:^(NSDictionary *responseDic){
        [SVProgressHUD dismiss];
        if(self.currentPage == 1){
            [self.dataArray removeAllObjects];
        }
        NSArray *itemsArray = [responseDic objectForKey:@"rows"];
        [self.dataArray addObjectsFromArray:[NSArray yy_modelArrayWithClass:[VBWaitDealListModel class] json:itemsArray]];
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
    return [tableView fd_heightForCellWithIdentifier:@"VBWaitDealTableViewCell" configuration:^(VBWaitDealTableViewCell *cell) {
        @strongify(self);
        VBWaitDealListModel *itemModel = [self.dataArray objectAtIndex:indexPath.row];
        cell.itemModel = itemModel;
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    VBWaitDealTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VBWaitDealTableViewCell"];
    VBWaitDealListModel *itemModel = [self.dataArray objectAtIndex:indexPath.row];
    cell.itemModel = itemModel;
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
    detailVC.uploadDataSource = [RACSubject subject];
    @weakify(self)
    [detailVC.uploadDataSource subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self.dataTableView.mj_header beginRefreshing];
    }];
    [self.navigationController pushViewController:detailVC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
@end
