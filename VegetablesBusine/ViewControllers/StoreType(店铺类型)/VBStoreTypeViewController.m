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
    @weakify(self)
    [getListRequest startRequestWithArraySuccess:^(NSArray *responseArray) {
        @strongify(self)
        [SVProgressHUD dismiss];
        [self.dataArray addObjectsFromArray:[NSArray yy_modelArrayWithClass:[VBStoreTypeModel class] json:responseArray]];
        for (VBStoreTypeModel *model in self.dataArray) {
            if (self.selectedTypeName.length > 0 && [self.selectedTypeName isEqualToString:model.typeName]) {
                model.isSelect = !model.isSelect;
            }
        }
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
        NSMutableArray *typeNameArray = [NSMutableArray array];
        for(VBStoreTypeModel *itemModel in self.dataArray){
            if(itemModel.isSelect){
                [storeIdArray addObject:itemModel.typeId];
                [typeNameArray addObject:itemModel.typeName];
            }
        }
        if(storeIdArray.count == 0){
            [SVProgressHUD showErrorWithStatus:@"请选择店铺类型"];
            return ;
        }
        NSString *storeTypeId = [storeIdArray componentsJoinedByString:@","];
        NSString *typeName = [typeNameArray componentsJoinedByString:@"、"];
        [SVProgressHUD show];
        NSString *shopID = [CommonTools fetchShopID];
        VBSetupStoreTypeRequest *submitRequest = [[VBSetupStoreTypeRequest alloc] initWithShopId:storeTypeId storeTypeId:@""];
        [submitRequest startRequestWithDicSuccess:^(NSDictionary *responseDic) {
            [SVProgressHUD showInfoWithStatus:@"设置成功"];
            [[NSNotificationCenter defaultCenter] postNotificationName:VBUploadStoreSetupInfoNotification object:nil];
            if (self.selectItemBlock) {
                self.selectItemBlock(typeName);
            }
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
    for (VBStoreTypeModel *m in self.dataArray) {
        m.isSelect = NO;
    }
    model.isSelect = YES;
    [tableView reloadData];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.f;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
