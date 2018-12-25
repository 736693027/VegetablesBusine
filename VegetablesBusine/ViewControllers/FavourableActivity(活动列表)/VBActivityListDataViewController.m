//
//  VBActivityListDataViewController.m
//  VegetablesBusine
//
//  Created by 刘少轩 on 2018/6/26.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "VBActivityListDataViewController.h"
#import <Masonry/Masonry.h>
#import "VBActivityListDataTableViewCell.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import "VBAlterView.h"
#import "VBGetActivityListRequest.h"
#import "VBActivityListModel.h"

@interface VBActivityListDataViewController ()

@end

@implementation VBActivityListDataViewController

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
    NSString *cellClassName = NSStringFromClass([VBActivityListDataTableViewCell class]);
    [self tableRegisterNibName:cellClassName cellReuseIdentifier:cellClassName estimatedRowHeight:175];
    
    UIView *tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 15)];
    tableFooterView.backgroundColor = [UIColor clearColor];
    self.dataTableView.tableFooterView = tableFooterView;
}
- (void)requestListData {
    [SVProgressHUD show];
    VBGetActivityListRequest *dataRequest = [[VBGetActivityListRequest alloc] initWithCurrentPage:self.currentPage tab:self.listType];
    [dataRequest startRequestWithDicSuccess:^(NSDictionary *responseDic){
        [SVProgressHUD dismiss];
        if(self.currentPage == 1){
            [self.dataArray removeAllObjects];
        }
        NSArray *itemsArray = [responseDic objectForKey:@"rows"];
        [self.dataArray addObjectsFromArray:[NSArray yy_modelArrayWithClass:[VBActivityListModel class] json:itemsArray]];
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
    VBActivityListDataTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VBActivityListDataTableViewCell"];
    VBActivityListModel *itemModel = [self.dataArray objectAtIndex:indexPath.row];
    cell.itemModel = itemModel;
    cell.deleteSuccessSubject = [RACSubject subject];
    @weakify(self)
    [cell.deleteSuccessSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [self.dataTableView.mj_header beginRefreshing];
    }];
    return cell;
}

#pragma mark tableview delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 175;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
