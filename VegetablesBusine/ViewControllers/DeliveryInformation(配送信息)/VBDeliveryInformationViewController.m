//
//  VBDeliveryInformationViewController.m
//  VegetablesBusine
//
//  Created by Apple on 2018/6/11.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "VBDeliveryInformationViewController.h"
#import "VBDeliveryInformationTableViewCell.h"
#import <Masonry/Masonry.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import "VBDeliverySetupRequest.h"

@interface VBDeliveryInformationViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *dataTableView;
@property (strong, nonatomic) NSMutableArray *dataArray;
@end

@implementation VBDeliveryInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArray = [NSMutableArray arrayWithObjects:@"0",@"0",@"24小时0", nil];
    NSString *cellName = NSStringFromClass([VBDeliveryInformationTableViewCell class]);
    [self.dataTableView registerNib:[UINib nibWithNibName:cellName bundle:nil] forCellReuseIdentifier:cellName];
    UIView *tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 55)];
    tableFooterView.backgroundColor = [CommonTools changeColor:@"0xf0f0f0"];
    self.dataTableView.tableFooterView = tableFooterView;
    UIButton *saveButton = [[UIButton alloc] init];
    saveButton.backgroundColor = [CommonTools changeColor:@"0x01cd88"];
    saveButton.titleLabel.font = [UIFont systemFontOfSize:17];
    [saveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [saveButton setTitle:@"保存" forState:UIControlStateNormal];
    saveButton.layer.cornerRadius = 3;
    [tableFooterView addSubview:saveButton];
    [saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset(10);
        make.bottom.offset(0);
        make.right.offset(-10);
    }];
    @weakify(self)
    [[saveButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        [self.view endEditing:YES];
        NSString *price = self.dataArray[0];
        NSString *cateringTime = self.dataArray[1];
        NSString *deliveryTime = self.dataArray[2];
        if(price.length == 0){
            [SVProgressHUD showErrorWithStatus:@"请输入起送价格"];
            return;
        }else if(cateringTime.length == 0){
            [SVProgressHUD showErrorWithStatus:@"请输入配送时间"];
            return;
        }else if(deliveryTime.length == 0){
            [SVProgressHUD showErrorWithStatus:@"请输入送送时间"];
            return;
        }
        [SVProgressHUD show];
        VBDeliverySetupRequest *submit = [[VBDeliverySetupRequest alloc] initWithPrice:price cateringTime:cateringTime deliveryTime:deliveryTime];
        [submit startRequestWithDicSuccess:^(NSDictionary *responseDic) {
            @strongify(self)
            [SVProgressHUD showInfoWithStatus:@"修改成功"];
            [self.navigationController popViewControllerAnimated:YES];
        } failModel:^(LBResponseModel *errorModel) {
            [SVProgressHUD showErrorWithStatus:errorModel.message];
        } fail:^(YTKBaseRequest *request) {
            [SVProgressHUD showErrorWithStatus:@"修改失败"];
        }];
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    VBDeliveryInformationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VBDeliveryInformationTableViewCell"];
    cell.textFieldSubject = [RACSubject subject];
    @weakify(self)
    [cell.textFieldSubject subscribeNext:^(NSString * _Nullable text) {
        @strongify(self)
        [self.dataArray replaceObjectAtIndex:indexPath.row withObject:text];
    }];
    cell.textField.text = self.dataArray[indexPath.row];
    cell.typeLabel.text = indexPath.row==0?@"元":@"分钟";
    switch (indexPath.row) {
        case 0:
            cell.titleLabel.text = @"起送价格：";
            break;
        case 1:
            cell.titleLabel.text = @"配餐时间：";
            break;
        case 2:
            cell.titleLabel.text = @"送达时间：";
            break;
        default:
            break;
    }
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
