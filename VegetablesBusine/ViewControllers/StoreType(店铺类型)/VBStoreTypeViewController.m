//
//  VBStoreTypeViewController.m
//  VegetablesBusine
//
//  Created by 刘少轩 on 2018/6/24.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "VBStoreTypeViewController.h"
#import "VBStoreTypeTableViewCell.h"
#import "VBStoreTypeModel.h"
#import "VBGetAllStoresRequest.h"
#import "VBSetupStoreTypeRequest.h"

@interface VBStoreTypeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *dataTableView;
@property (strong, nonatomic) NSMutableArray *dataArray;

@end

@implementation VBStoreTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"店铺类型";
    self.dataArray = [NSMutableArray array];
    NSString *className = NSStringFromClass([VBStoreTypeTableViewCell class]);
    [self.dataTableView registerNib:[UINib nibWithNibName:className bundle:nil] forCellReuseIdentifier:className];
    self.dataTableView.tableFooterView = [UIView new];
    [SVProgressHUD show];
    VBGetAllStoresRequest *getListRequest = [[VBGetAllStoresRequest alloc] init];
    [getListRequest startRequestWithDicSuccess:^(NSDictionary *responseDic) {
        [SVProgressHUD dismiss];
        NSArray *itemsArray = [responseDic objectForKey:@"rows"];
        [self.dataArray addObjectsFromArray:[NSArray yy_modelArrayWithClass:[VBStoreTypeModel class] json:itemsArray]];
        [self.dataTableView reloadData];
    } failModel:^(LBResponseModel *errorModel) {
        [SVProgressHUD showErrorWithStatus:errorModel.message];
    } fail:^(YTKBaseRequest *request) {
        [SVProgressHUD showErrorWithStatus:@"店铺类型获取失败"];
    }];
    
    UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [submitButton setTitle:@"确定" forState:UIControlStateNormal];
    submitButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [submitButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [[submitButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        NSMutableArray *storeIdArray = [NSMutableArray array];
        for(VBStoreTypeModel *itemModel in self.dataArray){
            if(itemModel.isSelect){
                [storeIdArray addObject:itemModel.shopId];
            }
        }
        if(storeIdArray.count == 0){
            [SVProgressHUD showErrorWithStatus:@"请选择店铺类型"];
            return ;
        }
        NSString *storeTypeId = [storeIdArray componentsJoinedByString:@","];
        [SVProgressHUD show];
        VBSetupStoreTypeRequest *submitRequest = [[VBSetupStoreTypeRequest alloc] initWithShopId:@"" storeTypeId:storeTypeId];
        [submitRequest startRequestWithDicSuccess:^(NSDictionary *responseDic) {
            [SVProgressHUD showInfoWithStatus:@"设置成功"];
            [[NSNotificationCenter defaultCenter] postNotificationName:VBUploadStoreSetupInfoNotification object:nil];
            [self.navigationController popViewControllerAnimated:YES];
        } failModel:^(LBResponseModel *errorModel) {
            [SVProgressHUD showErrorWithStatus:errorModel.message];
        } fail:^(YTKBaseRequest *request) {
            [SVProgressHUD showErrorWithStatus:@"设置失败"];
        }];
        
    }];
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:submitButton];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}
#pragma mark tableview datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    VBStoreTypeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VBStoreTypeTableViewCell"];
    VBStoreTypeModel *model = [self.dataArray objectAtIndex:indexPath.row];
    cell.model = model;
    return cell;
}
#pragma mark tableview delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    VBStoreTypeModel *model = [self.dataArray objectAtIndex:indexPath.row];
    model.isSelect = !model.isSelect;
    VBStoreTypeTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if(model.isSelect){
        [cell.stateImageView setImage:[UIImage imageNamed:@"checkbox1_checked"]];
    }else{
        [cell.stateImageView setImage:[UIImage imageNamed:@"checkbox1_unchecked"]];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.f;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
