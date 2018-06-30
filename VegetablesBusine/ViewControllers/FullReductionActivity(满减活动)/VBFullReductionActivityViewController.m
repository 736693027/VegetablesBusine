//
//  VBFullReductionActivityViewController.m
//  VegetablesBusine
//
//  Created by 刘少轩 on 2018/6/30.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "VBFullReductionActivityViewController.h"
#import "VBActivieBaseTableViewCell.h"
#import "VBActivityDateTimeTableViewCell.h"
#import "VBActivieSelectWeekTableViewCell.h"
#import "VBActivieSelectDateTimeTableViewCell.h"
#import "VBActivityRulesTableViewCell.h"
#import "VBActivityDateTimeEnumFile.h"
#import "VBTableFooterView.h"
#import <ReactiveObjC/ReactiveObjC.h>

@interface VBFullReductionActivityViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (assign, nonatomic) NSInteger totalActivityRulesCount;
@property (weak, nonatomic) IBOutlet UITableView *dataTableView;
@property (assign, nonatomic) VBActivityDateTimeType activityType;

@end

@implementation VBFullReductionActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"满减活动";
    self.totalActivityRulesCount = 1;
    self.activityType = VBActivityDateTimeDefault;
    [self.dataTableView registerNib:[UINib nibWithNibName:@"VBActivieBaseTableViewCell" bundle:nil] forCellReuseIdentifier:@"VBActivieBaseTableViewCell"];
    [self.dataTableView registerNib:[UINib nibWithNibName:@"VBActivityDateTimeTableViewCell" bundle:nil] forCellReuseIdentifier:@"VBActivityDateTimeTableViewCell"];
    [self.dataTableView registerNib:[UINib nibWithNibName:@"VBActivityRulesTableViewCell" bundle:nil] forCellReuseIdentifier:@"VBActivityRulesTableViewCell"];
    [self.dataTableView registerNib:[UINib nibWithNibName:@"VBActivieSelectWeekTableViewCell" bundle:nil] forCellReuseIdentifier:@"VBActivieSelectWeekTableViewCell"];
    [self.dataTableView registerNib:[UINib nibWithNibName:@"VBActivieSelectDateTimeTableViewCell" bundle:nil] forCellReuseIdentifier:@"VBActivieSelectDateTimeTableViewCell"];
    
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
    return self.totalActivityRulesCount;
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
        VBActivityRulesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VBActivityRulesTableViewCell"];
        cell.rulesSubject = [RACSubject subject];
        [cell.rulesSubject subscribeNext:^(id  _Nullable x) {
            @strongify(self)
            self.totalActivityRulesCount++;
            [self.dataTableView reloadData];
        }];
        return cell;
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
