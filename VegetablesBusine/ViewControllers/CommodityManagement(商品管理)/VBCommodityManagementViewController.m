//
//  VBCommodityManagementViewController.m
//  VegetablesBusine
//
//  Created by Apple on 2018/5/31.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "VBCommodityManagementViewController.h"
#import "VBMenuItemView.h"
#import "VBCommodityManagementTableViewCell.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import <Masonry/Masonry.h>
#import "VBNewManageCommodityClassificationViewController.h"
#import "VBAddGoodsViewController.h"
#import "VBCommodityManagementGetListAPI.h"
#import "VBCommodityManagementModel.h"
#import <UITableView_FDTemplateLayoutCell/UITableView+FDTemplateLayoutCell.h>

@interface VBCommodityManagementViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *menuScrollView;

@property (strong, nonatomic) NSArray *menuItemArray;
@property (strong, nonatomic) NSArray *dataArray;
@property (assign, nonatomic) NSInteger currentItemIndex;
@property (strong, nonatomic) UILabel *tableHeaderTitlaLabel;

@end

@implementation VBCommodityManagementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商品管理";
    [self creatTableViewViewTableViewStyle:UITableViewStylePlain];
    [self.dataTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(84);
        make.bottom.offset(-54);
        make.top.right.offset(0);
    }];
    [self tableRegisterNibName:@"VBCommodityManagementTableViewCell" cellReuseIdentifier:@"VBCommodityManagementTableViewCell" estimatedRowHeight:143];
    UIView *tableHeadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    self.tableHeaderTitlaLabel = [[UILabel alloc] init];
    [tableHeadView addSubview:self.tableHeaderTitlaLabel];
    self.tableHeaderTitlaLabel.font = [UIFont systemFontOfSize:14];
    [self.tableHeaderTitlaLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset(10);
    }];
    self.dataTableView.tableHeaderView = tableHeadView;
    
    [SVProgressHUD show];
    @weakify(self)
    VBCommodityManagementGetListAPI *getListAPI = [[VBCommodityManagementGetListAPI alloc] init];
    [getListAPI startRequestWithArraySuccess:^(NSArray *responseArray) {
        [SVProgressHUD dismiss];
        @strongify(self)
        self.menuItemArray = [NSArray yy_modelArrayWithClass:[VBCommodityManagementModel class] json:responseArray];
        if(self.menuItemArray.count>0){
            self.currentItemIndex = 0;
            VBCommodityManagementModel *model = [self.menuItemArray objectAtIndex:0];
            self.tableHeaderTitlaLabel.text = model.classificationName;
            self.dataArray = model.commodityInfo;
            [self.dataTableView reloadData];
            self.menuScrollView.contentSize = CGSizeMake(self.menuScrollView.width, MAX(self.menuScrollView.height, self.menuItemArray.count*60));
            [self.menuItemArray enumerateObjectsUsingBlock:^(VBCommodityManagementModel *_Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
                @strongify(self)
                VBMenuItemView *itemView = [[VBMenuItemView alloc] initWithFrame:CGRectMake(0, idx*60, self.menuScrollView.frame.size.width, 60)];
                itemView.titleLabel.text = model.classificationName;
                itemView.tag = idx+100;
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
                [[tap rac_gestureSignal] subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
                    @strongify(self)
                    VBMenuItemView *itemView = (VBMenuItemView *)x.view;
                    if(self.currentItemIndex != itemView.tag-100){
                        itemView.controlState = UIControlStateSelected;
                        VBMenuItemView *beformItemView = [self.menuScrollView viewWithTag:self.currentItemIndex+100];
                        beformItemView.controlState = UIControlStateNormal;
                        self.currentItemIndex = itemView.tag-100;
                        VBCommodityManagementModel *model = [self.menuItemArray objectAtIndex:self.currentItemIndex];
                        self.tableHeaderTitlaLabel.text = model.classificationName;
                        self.dataArray = model.commodityInfo;
                        [self.dataTableView reloadData];
                    }
                }];
                [itemView addGestureRecognizer:tap];
                itemView.controlState = (idx==self.currentItemIndex)?UIControlStateSelected:UIControlStateNormal;
                [self.menuScrollView addSubview:itemView];
            }];
        }
    } failModel:^(LBResponseModel *errorModel) {
        [SVProgressHUD showErrorWithStatus:errorModel.message];
    } fail:^(YTKBaseRequest *request) {
        [SVProgressHUD showErrorWithStatus:@"商品信息获取失败"];
    }];
}

#pragma mark tableview datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    @weakify(self)
    return [tableView fd_heightForCellWithIdentifier:@"VBCommodityManagementTableViewCell" configuration:^(VBCommodityManagementTableViewCell *cell) {
        @strongify(self)
        VBCommodityManagementItemModel *itemModel = [self.dataArray objectAtIndex:indexPath.row];
        cell.itemModel = itemModel;
    }];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    VBCommodityManagementTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VBCommodityManagementTableViewCell"];
    VBCommodityManagementItemModel *itemModel = [self.dataArray objectAtIndex:indexPath.row];
    cell.itemModel = itemModel;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    VBCommodityManagementItemModel *itemModel = [self.dataArray objectAtIndex:indexPath.row];
    VBAddGoodsViewController *editingVC = [[VBAddGoodsViewController alloc] init];
    editingVC.commodityID = itemModel.commodityId;
    [self.navigationController pushViewController:editingVC animated:YES];
}
- (IBAction)managerButtonClick:(id)sender {
    VBNewManageCommodityClassificationViewController *managerVC = [[VBNewManageCommodityClassificationViewController alloc] init];
    [self.navigationController pushViewController:managerVC animated:YES];
}
- (IBAction)addButtonClick:(id)sender {
    VBAddGoodsViewController *addGoodsVC = [[VBAddGoodsViewController alloc] init];
    [self.navigationController pushViewController:addGoodsVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
