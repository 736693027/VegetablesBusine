//
//  VBGoodsUnitViewController.m
//  VegetablesBusine
//
//  Created by 刘少轩 on 2018/7/1.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "VBGoodsUnitViewController.h"
#import "VBGoodsUnitTableViewCell.h"
#import "VBCommodityUnitsRequest.h"
@interface VBGoodsUnitViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *dataTableView;

@property (strong, nonatomic) NSArray *dataArray;

@end

@implementation VBGoodsUnitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"计量单位";
    [self loadData];
    [self.dataTableView registerNib:[UINib nibWithNibName:@"VBGoodsUnitTableViewCell" bundle:nil] forCellReuseIdentifier:@"VBGoodsUnitTableViewCell"];
    self.dataTableView.tableFooterView = [UIView new];
}

- (void)loadData {
    [SVProgressHUD show];
    @weakify(self)
    VBCommodityUnitsRequest *getListAPI = [[VBCommodityUnitsRequest alloc] init];
    [getListAPI startRequestWithArraySuccess:^(NSArray *responseArray) {
     [SVProgressHUD dismiss];
     @strongify(self)
        self.dataArray = [NSArray yy_modelArrayWithClass:[VBGoodsUnitModel class] json:responseArray];
        [self.dataTableView reloadData];
    } failModel:^(LBResponseModel *errorModel) {
        [SVProgressHUD showErrorWithStatus:errorModel.message];
    } fail:^(YTKBaseRequest *request) {
        [SVProgressHUD showErrorWithStatus:@"计量单位获取失败"];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    VBGoodsUnitTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VBGoodsUnitTableViewCell"];
    cell.titleLabel.text = [_dataArray[indexPath.row] unitName];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44.f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    VBGoodsUnitModel *model = _dataArray[indexPath.row];
    if (self.selectItemBlock) {
        _selectItemBlock(model.unitName, model.unitId);
    }
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end

@implementation VBGoodsUnitModel

@end
