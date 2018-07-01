//
//  VBGoodsUnitViewController.m
//  VegetablesBusine
//
//  Created by 刘少轩 on 2018/7/1.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "VBGoodsUnitViewController.h"
#import "VBGoodsUnitTableViewCell.h"

@interface VBGoodsUnitViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *dataTableView;

@end

@implementation VBGoodsUnitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"计量单位";
    [self.dataTableView registerNib:[UINib nibWithNibName:@"VBGoodsUnitTableViewCell" bundle:nil] forCellReuseIdentifier:@"VBGoodsUnitTableViewCell"];
    self.dataTableView.tableFooterView = [UIView new];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 30;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    VBGoodsUnitTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VBGoodsUnitTableViewCell"];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44.f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.navigationController popViewControllerAnimated:YES];
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
