//
//  VBOrderDetailViewController.m
//  VegetablesBusine
//
//  Created by 刘少轩 on 2018/5/21.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "VBOrderDetailViewController.h"
#import "VMOrderTotalTableViewCell.h"
#import "VMOrderDetailTableViewCell.h"
#import "VBOrderDetailOrderStateTableViewCell.h"
#import "VBOrderDetailOrderOwnerTableViewCell.h"
#import "VBOrderDetailInformationTableViewCell.h"


@interface VBOrderDetailViewController ()

@end

@implementation VBOrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单详情";
    [self creatTableViewViewTableViewStyle:UITableViewStyleGrouped];
    NSString *totalTableViewCell = NSStringFromClass([VMOrderTotalTableViewCell class]);
    NSString *orderDetailTableViewCell = NSStringFromClass([VMOrderDetailTableViewCell class]);
    NSString *orderStateTableViewCell = NSStringFromClass([VBOrderDetailOrderStateTableViewCell class]);
    NSString *orderOwnerTableViewCell = NSStringFromClass([VBOrderDetailOrderOwnerTableViewCell class]);
    NSString *informationTableViewCell = NSStringFromClass([VBOrderDetailOrderOwnerTableViewCell class]);
    [self tableRegisterNibName:totalTableViewCell cellReuseIdentifier:totalTableViewCell estimatedRowHeight:503];
    [self tableRegisterNibName:orderDetailTableViewCell cellReuseIdentifier:orderDetailTableViewCell estimatedRowHeight:503];
    [self tableRegisterNibName:orderStateTableViewCell cellReuseIdentifier:orderStateTableViewCell estimatedRowHeight:503];
    [self tableRegisterNibName:orderOwnerTableViewCell cellReuseIdentifier:orderOwnerTableViewCell estimatedRowHeight:503];
    [self tableRegisterNibName:informationTableViewCell cellReuseIdentifier:informationTableViewCell estimatedRowHeight:503];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0||section == 1||section == 3){
        return 1;
    }
    return 6;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        VBOrderDetailOrderStateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VBOrderDetailOrderStateTableViewCell"];
        return cell;
    }else if(indexPath.section == 1){
        VBOrderDetailOrderOwnerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VBOrderDetailOrderOwnerTableViewCell"];
        return cell;
    }else if (indexPath.section == 2){
        if(indexPath.row==5){
            VMOrderTotalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VMOrderTotalTableViewCell"];
            return cell;
        }else{
            VMOrderDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VMOrderDetailTableViewCell"];
            return cell;
        }
    }else{
        VBOrderDetailInformationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VBOrderDetailInformationTableViewCell"];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        return 108.f;
    }else if (indexPath.section == 1){
        return 110.f;
    }else if (indexPath.section == 2){
        if(indexPath.row == 5){
            return 165.f;
        }else{
            return 81.f;
        }
    }else{
        return 185.f;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10.f;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
