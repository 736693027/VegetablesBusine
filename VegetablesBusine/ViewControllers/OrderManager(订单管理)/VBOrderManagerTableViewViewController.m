//
//  VBOrderManagerTableViewViewController.m
//  VegetablesBusine
//
//  Created by Apple on 2018/5/9.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "VBOrderManagerTableViewViewController.h"
#import <Masonry/Masonry.h>
#import "VBOrderManagerTableViewCell.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import "VBAlterView.h"
#import "VBOrderDetailViewController.h"
#import "VBOrderManagerListRequest.h"
#import "VBWaitDealListModel.h"
#import <UITableView_FDTemplateLayoutCell/UITableView+FDTemplateLayoutCell.h>

@interface VBOrderManagerTableViewViewController ()

@end

@implementation VBOrderManagerTableViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creatTableViewViewTableViewStyle:UITableViewStylePlain];
    [self.dataTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.left.offset(0);
        make.bottom.mas_equalTo(self.view.mas_bottom);
        make.width.offset(SCREEN_WIDTH);
    }];
    self.dataTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.dataTableView.backgroundColor = [CommonTools changeColor:@"0xECECEC"];
    NSString *cellClassName = NSStringFromClass([VBOrderManagerTableViewCell class]);
    [self tableRegisterNibName:cellClassName cellReuseIdentifier:cellClassName estimatedRowHeight:415];
    
    UIView *tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 15)];
    tableFooterView.backgroundColor = [UIColor clearColor];
    self.dataTableView.tableFooterView = tableFooterView;
}
- (void)requestListData{
    [SVProgressHUD show];
    VBOrderManagerListRequest *dataRequest = [[VBOrderManagerListRequest alloc] initWithCurrentPage:self.currentPage startDate:self.searchDateTime tab:(NSInteger)self.viewStyle];
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    VBOrderManagerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VBOrderManagerTableViewCell"];
    VBWaitDealListModel *itemModel = [self.dataArray objectAtIndex:indexPath.row];
    cell.itemModel = itemModel;
    cell.cellType = self.viewStyle;
    return cell;
}

#pragma mark tableview delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    @weakify(self)
    return [tableView fd_heightForCellWithIdentifier:@"VBOrderManagerTableViewCell" configuration:^(VBOrderManagerTableViewCell *cell) {
        @strongify(self)
        VBWaitDealListModel *itemModel = [self.dataArray objectAtIndex:indexPath.row];
        cell.itemModel = itemModel;
        cell.cellType = self.viewStyle;
    }];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    VBOrderDetailViewController *detailVC = [[VBOrderDetailViewController alloc] init];
    detailVC.hidesBottomBarWhenPushed = YES;
    detailVC.orderType = VBOrderDetailTypeOrderManager;
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
    // Dispose of any resources that can be recreated.
}

@end
