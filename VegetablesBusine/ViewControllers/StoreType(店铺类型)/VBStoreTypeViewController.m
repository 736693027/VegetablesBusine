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

@interface VBStoreTypeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *dataTableView;
@property (strong, nonatomic) NSMutableArray *dataArray;

@end

@implementation VBStoreTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"店铺类型";
    NSArray *textArray = @[@"蔬菜",@"生鲜鱼肉",@"干调",@"米面粮油",@"酒类饮品",@"半成品冻货",@"合作社",@"生活服务",@"绿色食品加工",@"水果干果",@"麻辣烫",@"特价区"];
    self.dataArray = [NSMutableArray array];
    for(NSString *text in textArray){
        VBStoreTypeModel *model = [[VBStoreTypeModel alloc] init];
        model.typeName = text;
        [self.dataArray addObject:model];
    }
    NSString *className = NSStringFromClass([VBStoreTypeTableViewCell class]);
    [self.dataTableView registerNib:[UINib nibWithNibName:className bundle:nil] forCellReuseIdentifier:className];
    self.dataTableView.tableFooterView = [UIView new];
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
    cell.model = model;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.f;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
