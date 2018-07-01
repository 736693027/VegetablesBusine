//
//  VBGivingActivityViewController.m
//  VegetablesBusine
//
//  Created by 刘少轩 on 2018/7/1.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "VBGivingActivityViewController.h"
#import "VBActivieBaseTableViewCell.h"
#import "VBActivityDateTimeTableViewCell.h"
#import "VBActivieSelectWeekTableViewCell.h"
#import "VBActivieSelectDateTimeTableViewCell.h"
#import "VBDiscountActivityTableViewCell.h"
#import "VBGivingActivityTableViewCell.h"
#import "VBActivityDateTimeEnumFile.h"
#import "VBTableFooterView.h"
#import <ReactiveObjC/ReactiveObjC.h>

@interface VBGivingActivityViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *dataTableView;
@property (assign, nonatomic) VBActivityDateTimeType activityType;

@end

@implementation VBGivingActivityViewController

- (void)navRightButtonClicked:(UIButton *)sender{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"创建必读" message:@"1.同一类型活动只能创建一个(不包含已结算)\n2.活动开始时间是指当日00：00：00\n3.活动结束时间是指当日23：59：59" preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:confirmAction];
    [self presentViewController:alertController animated:YES completion:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"折扣活动";
    [navRrightBtn setTitle:@"创建必读" forState:UIControlStateNormal];
    navRrightBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [navRrightBtn setTitleColor:[CommonTools changeColor:@"0xfe7316"] forState:UIControlStateNormal];
    self.activityType = VBActivityDateTimeDefault;
    [self.dataTableView registerNib:[UINib nibWithNibName:@"VBActivieBaseTableViewCell" bundle:nil] forCellReuseIdentifier:@"VBActivieBaseTableViewCell"];
    [self.dataTableView registerNib:[UINib nibWithNibName:@"VBActivityDateTimeTableViewCell" bundle:nil] forCellReuseIdentifier:@"VBActivityDateTimeTableViewCell"];
    [self.dataTableView registerNib:[UINib nibWithNibName:@"VBDiscountActivityTableViewCell" bundle:nil] forCellReuseIdentifier:@"VBDiscountActivityTableViewCell"];
    [self.dataTableView registerNib:[UINib nibWithNibName:@"VBActivieSelectWeekTableViewCell" bundle:nil] forCellReuseIdentifier:@"VBActivieSelectWeekTableViewCell"];
    [self.dataTableView registerNib:[UINib nibWithNibName:@"VBActivieSelectDateTimeTableViewCell" bundle:nil] forCellReuseIdentifier:@"VBActivieSelectDateTimeTableViewCell"];
    [self.dataTableView registerNib:[UINib nibWithNibName:@"VBGivingActivityTableViewCell" bundle:nil] forCellReuseIdentifier:@"VBGivingActivityTableViewCell"];
    
    VBTableFooterView *tableFooterView = [[[NSBundle mainBundle] loadNibNamed:@"VBTableFooterView" owner:self options:nil] lastObject];
    tableFooterView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 80);
    self.dataTableView.tableFooterView = tableFooterView;
}

#pragma mark tableview datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0){
        if(self.activityType == VBActivityDateTimeDefault)
            return 2;
        else
            return 3;
    }
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    @weakify(self);
    if(indexPath.section == 0){
        if(indexPath.row == 0){
            VBActivieBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VBActivieBaseTableViewCell"];
            return cell;
        }else if(indexPath.row == 1){
            VBActivityDateTimeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VBActivityDateTimeTableViewCell"];
            cell.activityTypeSubject = [RACSubject subject];
            
            [cell.activityTypeSubject subscribeNext:^(NSNumber * _Nullable index) {
                @strongify(self)
                switch (index.integerValue) {
                    case 0:
                        self.activityType = VBActivityDateTimeDefault;
                        break;
                    case 1:
                        self.activityType = VBActivityDateTimeEveryWeek;
                        break;
                    case 2:
                        self.activityType = VBActivityDateTimeCustom;
                        break;
                    default:
                        break;
                }
                [self.dataTableView reloadData];
            }];
            return cell;
        }else{
            if(self.activityType == VBActivityDateTimeEveryWeek){
                VBActivieSelectWeekTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VBActivieSelectWeekTableViewCell"];
                return cell;
            }else{
                VBActivieSelectDateTimeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VBActivieSelectDateTimeTableViewCell"];
                return cell;
            }
        }
    }else{
        if(indexPath.row == 0){
            VBDiscountActivityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VBDiscountActivityTableViewCell"];
            cell.titleLabel.text = @"满赠条件";
            cell.unitLabel.text = @"元";
            return cell;
        }else{
            VBGivingActivityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VBGivingActivityTableViewCell"];
            return cell;
        }
        
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0 && indexPath.row == 2 && self.activityType == VBActivityDateTimeEveryWeek){
        return 78.f;
    }
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section == 0)
        return 0.0001;
    else
        return 20.f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0001;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
