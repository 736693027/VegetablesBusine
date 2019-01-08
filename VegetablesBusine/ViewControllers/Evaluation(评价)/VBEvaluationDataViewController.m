//
//  VBEvaluationDataViewController.m
//  VegetablesBusine
//
//  Created by 刘少轩 on 2018/6/24.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "VBEvaluationDataViewController.h"
#import "VBEvaluationDataTableViewCell.h"
#import <MJRefresh/MJRefresh.h>
#import "VBListDataRequest.h"
#import "VBEvaluationDataModel.h"
#import <UITableView_FDTemplateLayoutCell/UITableView+FDTemplateLayoutCell.h>

@interface VBEvaluationDataViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *dataTableView;
@property (strong ,nonatomic) NSMutableArray *dataArray;
@property (assign, nonatomic) NSInteger currentPage;
@end

@implementation VBEvaluationDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = [NSMutableArray array];
    self.currentPage = 1;
    [self.dataTableView registerNib:[UINib nibWithNibName:@"VBEvaluationDataTableViewCell" bundle:nil] forCellReuseIdentifier:@"VBEvaluationDataTableViewCell"];
    __weak typeof(self) weakSelf = self;
    self.dataTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.currentPage = 1;
        [self requestListData];
        [weakSelf.dataTableView.mj_header endRefreshing];
    }];
    self.dataTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.currentPage++;
        [self requestListData];
        [weakSelf.dataTableView.mj_footer endRefreshing];
    }];
    [self.dataTableView.mj_header beginRefreshing];
}
- (void)requestListData {
    [SVProgressHUD show];
    VBListDataRequest *dataRequest = [[VBListDataRequest alloc] initWithPage:1 rows:20 tag:self.tabInterge requestType:VBListDataRequestEvaluationList];
    [dataRequest startRequestWithDicSuccess:^(NSDictionary *responseDic){
        [SVProgressHUD dismiss];
        if(self.currentPage == 1){
            [self.dataArray removeAllObjects];
        }
        NSArray *itemsArray = [responseDic objectForKey:@"rows"];
        [self.dataArray addObjectsFromArray:[NSArray yy_modelArrayWithClass:[VBEvaluationDataModel class] json:itemsArray]];
        [self.dataTableView reloadData];
    } failModel:^(LBResponseModel *errorModel) {
        [SVProgressHUD showErrorWithStatus:errorModel.message];
    } fail:^(YTKBaseRequest *request) {
        [SVProgressHUD showErrorWithStatus:@"获取失败"];
    }];
}

#pragma mark tableview datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    VBEvaluationDataTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VBEvaluationDataTableViewCell"];
    VBEvaluationDataModel *itemModel = [self.dataArray objectAtIndex:indexPath.row];
    cell.itemModel = itemModel;
    cell.viewController = self;
    cell.replySuccessSubject = [RACSubject subject];
    @weakify(self)
    [cell.replySuccessSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [self.dataTableView.mj_header beginRefreshing];
    }];
    return cell;
}

#pragma mark delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    @weakify(self)
    return [tableView fd_heightForCellWithIdentifier:@"VBEvaluationDataTableViewCell" configuration:^(VBEvaluationDataTableViewCell *cell) {
        @strongify(self)
        VBEvaluationDataModel *itemModel = [self.dataArray objectAtIndex:indexPath.row];
        cell.itemModel = itemModel;
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
