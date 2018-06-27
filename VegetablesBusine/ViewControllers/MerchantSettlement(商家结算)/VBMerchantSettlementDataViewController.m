//
//  VBMerchantSettlementDataViewController.m
//  VegetablesBusine
//
//  Created by 刘少轩 on 2018/6/27.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "VBMerchantSettlementDataViewController.h"
#import "VBMerchantSettlementDataTableViewCell.h"

@interface VBMerchantSettlementDataViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *dataTableView;

@end

@implementation VBMerchantSettlementDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.dataTableView registerNib:[UINib nibWithNibName:@"VBMerchantSettlementDataTableViewCell" bundle:nil] forCellReuseIdentifier:@"VBMerchantSettlementDataTableViewCell"];
}
#pragma mark tableview datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    VBMerchantSettlementDataTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VBMerchantSettlementDataTableViewCell"];
    return cell;
}
#pragma mark tableview delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70.f;
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
