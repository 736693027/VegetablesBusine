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
#import "VBAddNewActivetyRequest.h"
#import "VBEditorActivityRequest.h"
#import "VBEditiActivityModel.h"

@interface VBFullReductionActivityViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (assign, nonatomic) NSInteger totalActivityRulesCount;
@property (weak, nonatomic) IBOutlet UITableView *dataTableView;
@property (assign, nonatomic) VBActivityDateTimeType activityType;
@property (strong, nonatomic) NSMutableDictionary *parameter;
@property (strong, nonatomic) VBEditiActivityModel *editorModel;
@end

@implementation VBFullReductionActivityViewController

- (void)navRightButtonClicked:(UIButton *)sender{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"创建必读" message:@"1.同一类型活动只能创建一个(不包含已结算)\n2.活动开始时间是指当日00：00：00\n3.活动结束时间是指当日23：59：59" preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:confirmAction];
    [self presentViewController:alertController animated:YES completion:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.parameter = [NSMutableDictionary dictionary];
    [self.parameter setObject:@1 forKey:@"model"];
    [self.parameter setObject:@"满减活动" forKey:@"title"];
    NSMutableDictionary *ruleDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"",@"amount",@"",@"text", nil];
    NSMutableArray *rulesArray = [NSMutableArray arrayWithObject:ruleDict];
    [self.parameter setObject:rulesArray forKey:@"ruler"];
    if(self.activityId){
        [self.parameter setObject:self.activityId forKey:@"activeId"];
    }else{
        [self.parameter setObject:@"0" forKey:@"activeId"];
    }
    self.title = @"满减活动";
    [navRrightBtn setTitle:@"创建必读" forState:UIControlStateNormal];
    navRrightBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [navRrightBtn setTitleColor:[CommonTools changeColor:@"0xfe7316"] forState:UIControlStateNormal];
    self.totalActivityRulesCount = 1;
    self.activityType = VBActivityDateTimeDefault;
    [self.dataTableView registerNib:[UINib nibWithNibName:@"VBActivieBaseTableViewCell" bundle:nil] forCellReuseIdentifier:@"VBActivieBaseTableViewCell"];
    [self.dataTableView registerNib:[UINib nibWithNibName:@"VBActivityDateTimeTableViewCell" bundle:nil] forCellReuseIdentifier:@"VBActivityDateTimeTableViewCell"];
    [self.dataTableView registerNib:[UINib nibWithNibName:@"VBActivityRulesTableViewCell" bundle:nil] forCellReuseIdentifier:@"VBActivityRulesTableViewCell"];
    [self.dataTableView registerNib:[UINib nibWithNibName:@"VBActivieSelectWeekTableViewCell" bundle:nil] forCellReuseIdentifier:@"VBActivieSelectWeekTableViewCell"];
    [self.dataTableView registerNib:[UINib nibWithNibName:@"VBActivieSelectDateTimeTableViewCell" bundle:nil] forCellReuseIdentifier:@"VBActivieSelectDateTimeTableViewCell"];
    
    VBTableFooterView *tableFooterView = [[[NSBundle mainBundle] loadNibNamed:@"VBTableFooterView" owner:self options:nil] lastObject];
    tableFooterView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 80);
    @weakify(self)
    [[tableFooterView.submitButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.view endEditing:YES];
            VBAddNewActivetyRequest *addRequest = [[VBAddNewActivetyRequest alloc] initWithRuleParameter:[self.parameter modelToJSONString]];
            [addRequest startRequestWithDicSuccess:^(NSDictionary *responseDic) {
                [SVProgressHUD showInfoWithStatus:@"添加成功"];
                [self.navigationController popViewControllerAnimated:YES];
            } failModel:^(LBResponseModel *errorModel) {
                [SVProgressHUD showErrorWithStatus:errorModel.message];
            } fail:^(YTKBaseRequest *request) {
                [SVProgressHUD showErrorWithStatus:@"添加失败"];
            }];
        });
    }];
    self.dataTableView.tableFooterView = tableFooterView;
    
    if(self.activityId){
        @weakify(self)
        VBEditorActivityRequest *editorRequest = [[VBEditorActivityRequest alloc] initWithActivityId:self.activityId];
        [editorRequest startRequestWithDicSuccess:^(NSDictionary *responseDic) {
            @strongify(self)
            self.editorModel = [VBEditiActivityModel yy_modelWithJSON:responseDic];
            self.activityType = self.editorModel.activeType.integerValue;
             [self.parameter setObject:@(self.editorModel.activeType.integerValue) forKey:@"activeType"];
            self.totalActivityRulesCount = self.editorModel.ruler.count;
            [self.parameter setObject:self.editorModel.days forKey:@"days"];
            [self.parameter setObject:self.editorModel.startDateTime forKey:@"startDateTime"];
            [self.parameter setObject:self.editorModel.endDateTime forKey:@"endDateTime"];
            NSMutableArray *rulesArray = [NSMutableArray array];
            for(NSDictionary *dict in self.editorModel.ruler){
                NSMutableDictionary *ruleDict = [NSMutableDictionary dictionary];
                [ruleDict setObject:dict.allKeys.firstObject forKey:@"amount"];
                [ruleDict setObject:dict.allValues.firstObject forKey:@"text"];
                [rulesArray addObject:ruleDict];
            }
            [self.parameter setObject:rulesArray forKey:@"ruler"];
        } failModel:^(LBResponseModel *errorModel) {
            [SVProgressHUD showErrorWithStatus:errorModel.message];
        } fail:^(YTKBaseRequest *request) {
            [SVProgressHUD showErrorWithStatus:@"满减活动获取失败"];
        }];
    }
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
            cell.selectIndex = self.editorModel.activeType.integerValue;
            [cell.activityTypeSubject subscribeNext:^(NSNumber * _Nullable index) {
                @strongify(self)
                [self.parameter setObject:@(index.integerValue+1) forKey:@"activeType"];
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
                cell.selectWeekSubject = [RACSubject subject];
                cell.selectWeekResult = self.editorModel.days;
                @weakify(self);
                [cell.selectWeekSubject subscribeNext:^(NSString *  _Nullable weekString) {
                    @strongify(self);
                    [self.parameter setObject:weekString forKey:@"days"];
                }];
                return cell;
            }else{
                VBActivieSelectDateTimeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VBActivieSelectDateTimeTableViewCell"];
                cell.startDateTimeSubject = [RACSubject subject];
                [cell.startDateTimeButton setTitle:self.editorModel.startDateTime forState:UIControlStateNormal];
                @weakify(self);
                [cell.startDateTimeSubject subscribeNext:^(NSString *  _Nullable startDateTime) {
                    @strongify(self);
                    [self.parameter setObject:startDateTime forKey:@"startDateTime"];
                }];
                cell.endDateTimeSubject = [RACSubject subject];
                [cell.endDateTimeButton setTitle:self.editorModel.endDateTime forState:UIControlStateNormal];
                [cell.endDateTimeSubject subscribeNext:^(NSString *  _Nullable endDateTime) {
                    @strongify(self);
                    [self.parameter setObject:endDateTime forKey:@"endDateTime"];
                }];
                return cell;
            }
        }
    }else{
        VBActivityRulesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VBActivityRulesTableViewCell"];
        cell.rulesSubject = [RACSubject subject];
        [cell.rulesSubject subscribeNext:^(NSIndexPath * _Nullable indexPath) {
            @strongify(self)
            if(indexPath.row==0){
                if(self.totalActivityRulesCount == 4){
                    [SVProgressHUD showInfoWithStatus:@"最多加4条满减优惠"];
                    return ;
                }
                self.totalActivityRulesCount++;
                NSMutableDictionary *ruleDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"amount",@"",@"text",@"", nil];
                NSMutableArray *rulesArray = [self.parameter objectForKey:@"ruler"];
                [rulesArray addObject:ruleDict];
                [self.parameter setObject:rulesArray forKey:@"ruler"];
            }else{
                NSMutableArray *rulesArray = [self.parameter objectForKey:@"ruler"];
                [rulesArray removeObjectAtIndex:indexPath.row];
                self.totalActivityRulesCount--;
            }
            [self.dataTableView reloadData];
        }];
        cell.indexPath = indexPath;
        cell.rulesDataSubject = [RACSubject subject];
        if(indexPath.row<self.editorModel.ruler.count){
            NSDictionary *dict = [self.editorModel.ruler objectAtIndex:indexPath.row];
            cell.textField1.text = dict.allKeys.firstObject;
            cell.textField2.text = dict.allKeys.firstObject;
        }
        [cell.rulesDataSubject subscribeNext:^(NSDictionary *  _Nullable dict) {
            NSMutableArray *rulesArray = [self.parameter objectForKey:@"ruler"];
            [rulesArray removeObjectAtIndex:indexPath.row];
            [rulesArray addObject:dict];
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
