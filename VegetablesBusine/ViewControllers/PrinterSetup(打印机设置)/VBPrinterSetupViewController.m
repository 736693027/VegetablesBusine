//
//  VBPrinterSetupViewController.m
//  VegetablesBusine
//
//  Created by 刘少轩 on 2018/6/24.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "VBPrinterSetupViewController.h"
#import "VBPrinterSetupTableViewCell.h"
#import "VBBluetoothListViewController.h"

@interface VBPrinterSetupViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *dataTableView;

@end

@implementation VBPrinterSetupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"打印机设置";
    [self.dataTableView registerNib:[UINib nibWithNibName:@"VBPrinterSetupTableViewCell" bundle:nil] forCellReuseIdentifier:@"VBPrinterSetupTableViewCell"];
}
#pragma mark tableview datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    VBPrinterSetupTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VBPrinterSetupTableViewCell"];
    return cell;
}

#pragma mark tableview delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    VBBluetoothListViewController *listVC = [[VBBluetoothListViewController alloc] init];
    listVC.connectSuccessSubject = [RACSubject subject];
    [listVC.connectSuccessSubject subscribeNext:^(id  _Nullable x) {
        VBPrinterSetupTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.stateLabel.text = @"已连接";
    }];
    [self.navigationController pushViewController:listVC animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10.f;
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
