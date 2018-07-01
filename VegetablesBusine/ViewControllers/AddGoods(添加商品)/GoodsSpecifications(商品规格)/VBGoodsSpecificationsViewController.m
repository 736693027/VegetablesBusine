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

@interface VBGoodsSpecificationsViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *dataTableView;

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
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 8;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    VBGoodsUnitTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VBGoodsUnitTableViewCell"];
    cell.titleLabel.text = @"30斤整捆";
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
