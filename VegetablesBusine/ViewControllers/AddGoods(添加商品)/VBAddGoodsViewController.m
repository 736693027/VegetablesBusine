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
#import "VBGetGoodsInfoRequest.h"
#import "VBGoodsSpecificationsModel.h"
#import "VBAddGoodsInfoModel.h"
#import "VBManageCommodityClassificationModel.h"
#import "VBGoodsSpecificationsModel.h"
#import "VBManageCommodityEditClassificationRequest.h"

@interface VBAddGoodsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *dataTableView;
@property (strong, nonatomic) NSMutableArray *secondSecitonTitlesArray;
@property (strong, nonatomic) NSMutableArray *secondSecitonPlaceHolderArray;
@property (strong, nonatomic) VBAddGoodsInfoModel *dataItemModel;
@property (strong, nonatomic) UIImage *uploadImage;
@end

@implementation VBAddGoodsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.dataTableView registerNib:[UINib nibWithNibName:@"VBAddGoodsPhotoTableViewCell" bundle:nil] forCellReuseIdentifier:@"VBAddGoodsPhotoTableViewCell"];
    [self.dataTableView registerNib:[UINib nibWithNibName:@"VBAddGoodsUnitTableViewCell" bundle:nil] forCellReuseIdentifier:@"VBAddGoodsUnitTableViewCell"];
    [self.dataTableView registerNib:[UINib nibWithNibName:@"VBAddGoodsInfoTextFieldTableViewCell" bundle:nil] forCellReuseIdentifier:@"VBAddGoodsInfoTextFieldTableViewCell"];
    
    self.dataItemModel = [[VBAddGoodsInfoModel alloc]init];
    VBTableFooterView *tableFooterView = [[[NSBundle mainBundle] loadNibNamed:@"VBTableFooterView" owner:self options:nil] lastObject];
    tableFooterView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 80);
    self.dataTableView.tableFooterView = tableFooterView;
    __weak VBAddGoodsViewController *weakSelf = self;
    [tableFooterView setBtnClickBlock:^{
        [weakSelf saveAction];
    }];
    _secondSecitonTitlesArray = [NSMutableArray arrayWithObjects:@"规格名称：",@"商品价格：",@"库存：",nil];
    _secondSecitonPlaceHolderArray = [NSMutableArray arrayWithObjects:@"请选择商品规格",@"输入商品价格",@"输入商品库存数量", nil];
    if(self.commodityID){
        self.title = @"编辑商品";
        self.dataItemModel.commodityID = self.commodityID;
        VBGetGoodsInfoRequest *requestInfo = [[VBGetGoodsInfoRequest alloc] initWithCommodityId:self.commodityID];
        [requestInfo startRequestWithDicSuccess:^(NSDictionary *responseDic) {
            if ([responseDic allKeys].count > 0) {
                self.dataItemModel = [VBAddGoodsInfoModel yy_modelWithJSON:responseDic];
                NSMutableArray *arr = [[NSMutableArray alloc]init];
                for (VBGoodsSpecificationsItemModel *m in self.dataItemModel.standards) {
                    [arr addObject:m.standardsID];
                }
                self.dataItemModel.standards = [arr copy];
                [self.dataTableView reloadData];
            }
        } failModel:^(LBResponseModel *errorModel) {
            [SVProgressHUD showErrorWithStatus:errorModel.message];
        } fail:^(YTKBaseRequest *request) {
            [SVProgressHUD showErrorWithStatus:@"商品明细获取失败"];
        }];
    } else {
        self.title = @"添加新商品";
         self.dataItemModel.commodityID = @"";
    }
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
        if(self.dataItemModel.standards.count>3){
            return 3*self.dataItemModel.standards.count*2;
        }else{
            return 3;
        }
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     __weak VBAddGoodsViewController *weakSelf = self;
    if(indexPath.section == 0){
        VBAddGoodsPhotoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VBAddGoodsPhotoTableViewCell"];
        cell.itemModel = self.dataItemModel;
        cell.viewController = self;
        @weakify(self)
        cell.uploadNewImageSubject = [RACSubject subject];
        [cell.uploadNewImageSubject subscribeNext:^(UIImage *  _Nullable uploadImage) {
            @strongify(self)
            self.uploadImage = uploadImage;
        }];
        return cell;
    }else if (indexPath.section == 2){
        if(indexPath.row == 0){
            VBAddGoodsInfoTextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VBAddGoodsInfoTextFieldTableViewCell"];
            cell.titleLabel.text = @"餐盒费：";
            cell.infoTextField.placeholder = @"输入商品餐盒费";
            cell.infoTextField.text = self.dataItemModel.foodContainerPrice;
            [cell setInputBlock:^(NSString * text) {
                weakSelf.dataItemModel.foodContainerPrice = text;
            }];
            return cell;
        }else{
            VBAddGoodsUnitTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VBAddGoodsUnitTableViewCell"];
            if (indexPath.row == 1) {
                cell.titleLabel.text = @"计量单位";
                if (self.dataItemModel.unitName) {
                    cell.unitLabel.text = self.dataItemModel.unitName;
                } else {
                    cell.unitLabel.text = @"待定";
                }
            } else {
                cell.titleLabel.text = @"分类";
                if(self.dataItemModel.classify){
                    cell.unitLabel.text = self.dataItemModel.classify;
                }else{
                    cell.unitLabel.text = @"未分类";
                }
            }
            return cell;
        }
    }else{
        VBAddGoodsInfoTextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VBAddGoodsInfoTextFieldTableViewCell"];
        if(self.dataItemModel.standards.count>3){
            NSInteger index = indexPath.row/3;
            VBGoodsSpecificationsItemModel *itemModel = [self.dataItemModel.standards objectAtIndex:index];
            cell.titleLabel.text = _secondSecitonTitlesArray[indexPath.row%3];
            cell.infoTextField.placeholder = _secondSecitonPlaceHolderArray[indexPath.row%3];
            switch (indexPath.row%3) {
                case 0:
                    cell.infoTextField.placeholder = itemModel.standardsName;
                    break;
                case 1:
                    cell.infoTextField.placeholder = itemModel.price;
                    break;
                case 2:
                    cell.infoTextField.placeholder = itemModel.inventory;
                    break;
                default:
                    break;
            }
        }else{
            if (indexPath.row == 0) {
                cell.infoTextField.text = self.dataItemModel.standardName;
                [cell setInputBlock:^(NSString * text) {
                     weakSelf.dataItemModel.standardName = text;
                }];
            } else if (indexPath.row == 1) {
                cell.infoTextField.text = self.dataItemModel.price;
                [cell setInputBlock:^(NSString * text) {
                    weakSelf.dataItemModel.price = text;
                }];
            } else {
                cell.infoTextField.text = self.dataItemModel.inventory;
                [cell setInputBlock:^(NSString * text) {
                    weakSelf.dataItemModel.inventory = text;
                }];
            }
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
            if (self.dataItemModel.standards.count > 0) {
                specificationsVC.selectArray = [self.dataItemModel.standards mutableCopy];
            }
            [specificationsVC setCallBackBlock:^(NSArray * selectArr) {
                self.dataItemModel.standards = selectArr;
            }];
            [self.navigationController pushViewController:specificationsVC animated:YES];
        }];
        [[headerView.setupGoodsStyle rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self);
            VBAddCommodityClassificationView *addView = [VBAddCommodityClassificationView alterViewWithResult:^(NSString *name, NSString *number) {
                NSLog(@"-----%@-----%@",name,number);
            }];
            [addView show];
        }];
        headerView.setupGoodsStyle.hidden = YES;
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
            managerVC.didSelectItemSubject = [RACSubject subject];
            [managerVC.didSelectItemSubject subscribeNext:^(VBManageCommodityClassificationModel * _Nullable x) {
                self.dataItemModel.classify = x.classifyName;
                self.dataItemModel.classifyID = x.classifyID;
                [self.dataTableView reloadData];
            }];
            [self.navigationController pushViewController:managerVC animated:YES];
        }else if (indexPath.row == 1){
            VBGoodsUnitViewController *unitVC = [[VBGoodsUnitViewController alloc] init];
            @weakify(self);
            [unitVC setSelectItemBlock:^(NSString * unitName, NSString *unitID) {
               @strongify(self);
                self.dataItemModel.unitName = unitName;
                self.dataItemModel.uniti = unitID;
                [self.dataTableView reloadData];
            }];
            [self.navigationController pushViewController:unitVC animated:YES];
        }
    }
}

#pragma mark - 保存编辑
- (void)saveAction {
    if (!self.dataItemModel.name || !self.dataItemModel.subtitle || !self.dataItemModel.price || !self.dataItemModel.foodContainerPrice || !self.dataItemModel.uniti || !self.dataItemModel.classifyID || !self.dataItemModel.inventory) {
        [SVProgressHUD showErrorWithStatus:@"请填写完整商品信息"];
        return;
    }else if (!self.dataItemModel.standards&&self.commodityID.length>0){
        [SVProgressHUD showErrorWithStatus:@"请填写商品规格"];
        return;
    }
    [SVProgressHUD show];
    VBManageCommodityEditClassificationRequest *request = [[VBManageCommodityEditClassificationRequest alloc]initWithGoodsInfoModel:self.dataItemModel uploadImage:self.uploadImage];
    [request startRequestWithDicSuccess:^(NSDictionary *responseDic) {
         [SVProgressHUD showSuccessWithStatus:@"操作成功"];
        if (self.freshBlock) {
            self.freshBlock();
        }
         [self.navigationController popViewControllerAnimated:YES];
    } failModel:^(LBResponseModel *errorModel) {
         [SVProgressHUD showErrorWithStatus:errorModel.message];
    } fail:^(YTKBaseRequest *request) {
         [SVProgressHUD showErrorWithStatus:@"更新失败"];
    }];
}

@end
