//
//  VBMerchantSettlementDataViewController.m
//  VegetablesBusine
//
//  Created by 刘少轩 on 2018/6/27.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "VBMerchantSettlementDataViewController.h"
#import "VBMerchantSettlementDataTableViewCell.h"
#import "VBMerchantSettlementDataViewRequest.h"
#import <Masonry/Masonry.h>
#import <UITableView_FDTemplateLayoutCell/UITableView+FDTemplateLayoutCell.h>

@interface VBMerchantSettlementDataViewController ()
@end

@implementation VBMerchantSettlementDataViewController

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
    [self.dataTableView registerNib:[UINib nibWithNibName:@"VBMerchantSettlementDataTableViewCell" bundle:nil] forCellReuseIdentifier:@"VBMerchantSettlementDataTableViewCell"];
}

- (void)requestListData {
    [SVProgressHUD show];
    VBMerchantSettlementDataViewRequest *quest = [[VBMerchantSettlementDataViewRequest alloc]initWithTabNumber:_tabNumber currentPage:self.currentPage];
    [quest startRequestWithDicSuccess:^(NSDictionary *responseDic) {
        [SVProgressHUD dismiss];
        if(self.currentPage == 1){
            [self.dataArray removeAllObjects];
        }
        NSArray *itemsArray = [responseDic objectForKey:@"rows"];
        [self.dataArray addObjectsFromArray:[NSArray yy_modelArrayWithClass:[MerchantSettlementListModel class] json:itemsArray]];
        [self.dataTableView reloadData];
    } failModel:^(LBResponseModel *errorModel) {
       [SVProgressHUD showErrorWithStatus:errorModel.message];
    } fail:^(YTKBaseRequest *request) {
        [SVProgressHUD showErrorWithStatus:@"加载结算列表失败"];
    }];
}

#pragma mark tableview datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    VBMerchantSettlementDataTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VBMerchantSettlementDataTableViewCell"];
    cell.itemModel = self.dataArray[indexPath.row];
    return cell;
}
#pragma mark tableview delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70.f;
}

@end
