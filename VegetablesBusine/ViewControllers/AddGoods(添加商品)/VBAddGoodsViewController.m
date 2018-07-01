//
//  VBAddGoodsViewController.m
//  VegetablesBusine
//
//  Created by 刘少轩 on 2018/6/28.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "VBAddGoodsViewController.h"
#import "VBAddGoodsPhotoTableViewCell.h"
#import "VBAddGoodsUnitTableViewCell.h"
#import "VBAddGoodsInfoTextFieldTableViewCell.h"
#import "VBTableFooterView.h"
#import "VBTableSectionHeaderView.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import "VBManageCommodityClassificationViewController.h"
#import "VBGoodsUnitViewController.h"
#import "VBGoodsSpecificationsViewController.h"
#import "VBAddCommodityClassificationView.h"

@interface VBAddGoodsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *dataTableView;
@property (strong, nonatomic) NSMutableArray *secondSecitonTitlesArray;
@property (strong, nonatomic) NSMutableArray *secondSecitonPlaceHolderArray;
@property (assign, nonatomic) NSInteger totalProductSpecificationsCount;

@end

@implementation VBAddGoodsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title = @"添加新商品";
    [self.dataTableView registerNib:[UINib nibWithNibName:@"VBAddGoodsPhotoTableViewCell" bundle:nil] forCellReuseIdentifier:@"VBAddGoodsPhotoTableViewCell"];
    [self.dataTableView registerNib:[UINib nibWithNibName:@"VBAddGoodsUnitTableViewCell" bundle:nil] forCellReuseIdentifier:@"VBAddGoodsUnitTableViewCell"];
    [self.dataTableView registerNib:[UINib nibWithNibName:@"VBAddGoodsInfoTextFieldTableViewCell" bundle:nil] forCellReuseIdentifier:@"VBAddGoodsInfoTextFieldTableViewCell"];
    
    VBTableFooterView *tableFooterView = [[[NSBundle mainBundle] loadNibNamed:@"VBTableFooterView" owner:self options:nil] lastObject];
    tableFooterView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 80);
    self.dataTableView.tableFooterView = tableFooterView;
    _secondSecitonTitlesArray = [NSMutableArray arrayWithObjects:@"商品价格：",@"库存：",nil];
    _secondSecitonPlaceHolderArray = [NSMutableArray arrayWithObjects:@"输入商品价格",@"输入商品库存数量", nil];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 0){
        return 1;
    }else if (section == 2){
        return 3;
    }else{
        if(self.totalProductSpecificationsCount>0){
            return 3*self.totalProductSpecificationsCount;
        }else{
            return 2;
        }
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        VBAddGoodsPhotoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VBAddGoodsPhotoTableViewCell"];
        return cell;
    }else if (indexPath.section == 2){
        if(indexPath.row == 0){
            VBAddGoodsInfoTextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VBAddGoodsInfoTextFieldTableViewCell"];
            cell.titleLabel.text = @"餐盒费：";
            cell.infoTextField.placeholder = @"输入商品餐盒费";
            return cell;
        }else{
            VBAddGoodsUnitTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VBAddGoodsUnitTableViewCell"];
            cell.titleLabel.text = indexPath.row == 1?@"计量单位":@"分类";
            cell.unitLabel.text = indexPath.row == 1?@"待定":@"未分类";
            return cell;
        }
    }else{
        VBAddGoodsInfoTextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VBAddGoodsInfoTextFieldTableViewCell"];
        if(self.totalProductSpecificationsCount>0){
            cell.titleLabel.text = _secondSecitonTitlesArray[indexPath.row%3];
            cell.infoTextField.placeholder = _secondSecitonPlaceHolderArray[indexPath.row%3];
        }else{
            cell.titleLabel.text = _secondSecitonTitlesArray[indexPath.row];
            cell.infoTextField.placeholder = _secondSecitonPlaceHolderArray[indexPath.row];
        }
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        return 170;
    }else{
        return 50.f;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section == 0){
        return 0.0001;
    }else if (section == 1){
        return 10.f;
    }
    return 40.f;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if(section==2){
        VBTableSectionHeaderView *headerView = [[[NSBundle mainBundle] loadNibNamed:@"VBTableSectionHeaderView" owner:self options:nil] lastObject];
        @weakify(self);
        [[headerView.addGoodsButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIButton * _Nullable sender) {
            @strongify(self);
            VBGoodsSpecificationsViewController *specificationsVC = [[VBGoodsSpecificationsViewController alloc] init];
            [self.navigationController pushViewController:specificationsVC animated:YES];
        }];
        [[headerView.setupGoodsStyle rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self);
            VBAddCommodityClassificationView *addView = [VBAddCommodityClassificationView alterViewWithResult:^(NSString *name, NSString *number) {
                NSLog(@"-----%@-----%@",name,number);
            }];
            [addView show];
        }];
        return headerView;
    }else{
        return [UIView new];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0001;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.section == 2){
        if(indexPath.row == 2){
            VBManageCommodityClassificationViewController *managerVC = [[VBManageCommodityClassificationViewController alloc] init];
            [self.navigationController pushViewController:managerVC animated:YES];
        }else if (indexPath.row == 1){
            VBGoodsUnitViewController *unitVC = [[VBGoodsUnitViewController alloc] init];
            [self.navigationController pushViewController:unitVC animated:YES];
        }
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
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
