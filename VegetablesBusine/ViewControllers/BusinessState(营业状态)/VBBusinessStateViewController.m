//
//  VBBusinessStateViewController.m
//  VegetablesBusine
//
//  Created by Apple on 2018/6/12.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "VBBusinessStateViewController.h"
#import "VBBusinessStateTableViewCell.h"
#import "VBVBBusinessStateTextTableViewCell.h"
#import "VBBusinessStateHeadView.h"
#import <Masonry/Masonry.h>

@interface VBBusinessStateViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *dataTableView;

@end

@implementation VBBusinessStateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    VBBusinessStateHeadView *tableHeadView = [[[NSBundle mainBundle] loadNibNamed:@"VBBusinessStateHeadView" owner:self options:nil] lastObject];
    tableHeadView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 180);
    self.dataTableView.tableHeaderView = tableHeadView;
    self.dataTableView.tableFooterView = [UIView new];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        VBBusinessStateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VBBusinessStateTableViewCell"];
        if(cell == nil){
            cell = [[[NSBundle mainBundle] loadNibNamed:@"VBBusinessStateTableViewCell" owner:self options:nil] lastObject];
        }
        return cell;
    }else{
        VBVBBusinessStateTextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VBVBBusinessStateTextTableViewCell"];
        if(cell == nil){
            cell = [[[NSBundle mainBundle] loadNibNamed:@"VBVBBusinessStateTextTableViewCell" owner:self options:nil
                     ] lastObject];
        }
        return cell;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if(section == 0){
        UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 35)];
        [headView setBackgroundColor:[UIColor whiteColor]];
        UILabel *textLabel = [[UILabel alloc] init];
        textLabel.font = [UIFont systemFontOfSize:15];
        textLabel.text = @"设置营业时间";
        [headView addSubview:textLabel];
        [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(18);
            make.left.offset(10);
        }];
        return headView;
    }else{
        return [UIView new];
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if(section == 0){
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 70)];
        footerView.backgroundColor = [CommonTools changeColor:@"0xf0f0f0"];
        UIView *mainView = [[UIView alloc] init];
        mainView.backgroundColor = [UIColor whiteColor];
        [footerView addSubview:mainView];
        [mainView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.left.offset(0);
            make.height.offset(60);
        }];
        UIButton *addTimeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [addTimeButton setTitle:@"+添加时间段" forState:UIControlStateNormal];
        addTimeButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [addTimeButton setTitleColor:[CommonTools changeColor:@"0x54ade0"] forState:UIControlStateNormal];
        addTimeButton.layer.borderWidth = 1;
        addTimeButton.layer.borderColor = [CommonTools changeColor:@"0x9b9b9b"].CGColor;
        addTimeButton.layer.cornerRadius = 20;
        [mainView addSubview:addTimeButton];
        [addTimeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(mainView.mas_centerX);
            make.centerY.equalTo(mainView.mas_centerY);
            make.height.offset(40);
            make.width.offset(217);
        }];
        return footerView;
    }else{
        return [UIView new];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 70.f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section == 0){
         return 30.f;
    }else{
        return 0.00001;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        return 60.f;
    }else{
        return 50.f;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
@end
