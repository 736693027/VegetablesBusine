//
//  VBSetupViewController.m
//  VegetablesBusine
//
//  Created by Apple on 2018/6/10.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "VBSetupViewController.h"
#import "VBSetupTableViewCell.h"
#import <Masonry/Masonry.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import "VBShopIntroductionViewController.h"

@interface VBSetupViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *dataTableView;
@property (strong, nonatomic) NSArray *titleArray;
@property (strong, nonatomic) NSMutableArray *contentArray;
@property (strong, nonatomic) NSArray *viewContronllers;
@end

@implementation VBSetupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商品名称";
    _titleArray = @[@[@"营业状态",@"配送信息",@"自动接单"],@[@"店铺类型",@"订餐电话"],@[@"店铺地址",@"店铺公告",@"店铺简介"]];
    _contentArray = [NSMutableArray arrayWithObjects:@[@"状态、预订、配送时间",@"起送价、制作送达时间",@""],@[@"酒类饮品、酒类饮品",@"15213886984"],@[@"北京市海淀区",@"欢迎光临",@"店铺简介内容"], nil];
    _viewContronllers = @[@[@"VBBusinessStateViewController",@"VBDeliveryInformationViewController",@"自动接单"],@[@"VBStoreTypeViewController",@"VBShopIntroductionViewController"],@[@"VBShopIntroductionViewController",@"VBShopIntroductionViewController",@"VBShopIntroductionViewController"]];
    UIView *tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 48)];
    tableFooterView.backgroundColor = [UIColor whiteColor];
    self.dataTableView.tableFooterView = tableFooterView;
    UIButton *logoutButton = [[UIButton alloc] init];
    logoutButton.titleLabel.font = [UIFont systemFontOfSize:17];
    [logoutButton setTitleColor:[CommonTools changeColor:@"0x5dbd8b"] forState:UIControlStateNormal];
    [logoutButton setTitle:@"退出登录" forState:UIControlStateNormal];
    [tableFooterView addSubview:logoutButton];
    [logoutButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset(0);
        make.right.bottom.offset(0);
    }];
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:VBUploadStoreSetupInfoNotification object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        
    }];
}
#pragma mark tableView datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _titleArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *sectionArray = _titleArray[section];
    return sectionArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    VBSetupTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VBSetupTableViewCell"];
    if(cell == nil){
        cell = [[[NSBundle mainBundle] loadNibNamed:@"VBSetupTableViewCell" owner:self options:nil] lastObject];
    }
    NSArray *sectionArray = _titleArray[indexPath.section];
    cell.titleLabel.text = sectionArray[indexPath.row];
    NSArray *sectionContentArray = _contentArray[indexPath.section];
    cell.detaiLabel.text = sectionContentArray[indexPath.row];
    cell.stateSwitch.hidden = YES;
    cell.gotoImageView.hidden = NO;
    if(indexPath.section==0&&indexPath.row==2){
        cell.stateSwitch.hidden = NO;
        cell.gotoImageView.hidden = YES;
    }
    [[cell.stateSwitch rac_signalForControlEvents:UIControlEventValueChanged] subscribeNext:^(__kindof UISwitch * _Nullable sender) {
        
    }];
    return cell;
}
#pragma mark tableview datasource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 47.f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.00001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10.f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSArray *sectionArray = _viewContronllers[indexPath.section];
    NSArray *cellTitles = _titleArray[indexPath.section];
    NSArray *contents = _contentArray[indexPath.section];
    NSString *className = sectionArray[indexPath.row];
    Class viewControllerClass = NSClassFromString(className);
    UIViewController *viewController = [[viewControllerClass alloc] init];
    viewController.title = cellTitles[indexPath.row];
    viewController.hidesBottomBarWhenPushed = YES;
    if(indexPath.section == 2){
        VBShopIntroductionViewController *shopIntroductionsVC = (VBShopIntroductionViewController *)viewController;
        shopIntroductionsVC.textViewSubject = [RACSubject subject];
        shopIntroductionsVC.contentString = contents[indexPath.row];
        @weakify(self)
        [shopIntroductionsVC.textViewSubject subscribeNext:^(NSString * _Nullable text) {
            @strongify(self);
            VBSetupTableViewCell *cell = [self.dataTableView cellForRowAtIndexPath:indexPath];
            cell.detaiLabel.text = text;
        }];
    }
    [self.navigationController pushViewController:viewController animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
