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

@interface VBEvaluationDataViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *dataTableView;
@end

@implementation VBEvaluationDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.dataTableView registerNib:[UINib nibWithNibName:@"VBEvaluationDataTableViewCell" bundle:nil] forCellReuseIdentifier:@"VBEvaluationDataTableViewCell"];
    __weak typeof(self) weakSelf = self;
    self.dataTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf.dataTableView.mj_header endRefreshing];
    }];
    self.dataTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf.dataTableView.mj_footer endRefreshing];
    }];
}

#pragma mark tableview datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    VBEvaluationDataTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VBEvaluationDataTableViewCell"];
    return cell;
}

#pragma mark delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 94.f;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
