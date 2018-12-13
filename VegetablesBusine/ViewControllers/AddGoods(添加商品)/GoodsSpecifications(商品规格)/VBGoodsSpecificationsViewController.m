//
//  VBGoodsSpecificationsViewController.m
//  VegetablesBusine
//
//  Created by 刘少轩 on 2018/7/1.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "VBGoodsSpecificationsViewController.h"
#import "VBGoodsUnitTableViewCell.h"
#import "VBTableSectionHeaderView.h"
#import <Masonry/Masonry.h>
#import "VBGetGoodsSpecificationsRequest.h"
#import "VBGoodsSpecificationsModel.h"

@interface VBGoodsSpecificationsViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *dataTableView;
@property (copy, nonatomic) NSArray *dataArray;

@end

@implementation VBGoodsSpecificationsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"商品规格";
    [self.dataTableView registerNib:[UINib nibWithNibName:@"VBGoodsUnitTableViewCell" bundle:nil] forCellReuseIdentifier:@"VBGoodsUnitTableViewCell"];
    self.dataTableView.tableFooterView = [UIView new];
    
    UIView *tableViewHeadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
    tableViewHeadView.backgroundColor = [CommonTools changeColor:@"0xf0f0f0"];
    UILabel *headerLabel = [[UILabel alloc] init];
    headerLabel.font = [UIFont systemFontOfSize:13];
    headerLabel.textColor = [CommonTools changeColor:@"0x999999"];
    headerLabel.text = @"提示：点击选择，再次点击取消，最多添加俩种规格";
    [tableViewHeadView addSubview:headerLabel];
    [headerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.right.offset(-10);
        make.top.bottom.offset(0);
    }];
    self.dataTableView.tableHeaderView = tableViewHeadView;
    
    VBGetGoodsSpecificationsRequest *request = [[VBGetGoodsSpecificationsRequest alloc] init];
    @weakify(self)
    [request startRequestWithArraySuccess:^(NSArray *responseArray) {
        @strongify(self)
        self.dataArray = [NSArray yy_modelArrayWithClass:[VBGoodsSpecificationsModel class] json:responseArray];
        [self.dataTableView reloadData];
    } failModel:^(LBResponseModel *errorModel) {
        [SVProgressHUD showErrorWithStatus:errorModel.message];
    } fail:^(YTKBaseRequest *request) {
        [SVProgressHUD showErrorWithStatus:@"商品规格获取失败"];
    }];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    VBGoodsSpecificationsModel *model = [self.dataArray objectAtIndex:section];
    return model.standardsInfo.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    VBGoodsUnitTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VBGoodsUnitTableViewCell"];
    VBGoodsSpecificationsModel *model = [self.dataArray objectAtIndex:indexPath.section];
    VBGoodsSpecificationsItemModel *itemModel = [model.standardsInfo objectAtIndex:indexPath.row];
    cell.titleLabel.text = itemModel.standardsName;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    VBGoodsUnitTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44.f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40.f;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    VBTableSectionHeaderView *headerView = [[[NSBundle mainBundle] loadNibNamed:@"VBTableSectionHeaderView" owner:self options:nil] lastObject];
    headerView.addGoodsButton.hidden = YES;
    VBGoodsSpecificationsModel *model = [self.dataArray objectAtIndex:section];
    [headerView.setupGoodsStyle setTitle:model.title forState:UIControlStateNormal];
    return headerView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0001;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
