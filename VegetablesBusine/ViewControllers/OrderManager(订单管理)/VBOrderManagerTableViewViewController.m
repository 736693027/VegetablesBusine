//
//  VBOrderManagerTableViewViewController.m
//  VegetablesBusine
//
//  Created by Apple on 2018/5/9.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "VBOrderManagerTableViewViewController.h"
#import <Masonry/Masonry.h>
#import "VBOrderManagerTableViewCell.h"

@interface VBOrderManagerTableViewViewController ()

@end

@implementation VBOrderManagerTableViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.dataTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.left.offset(0);
        make.bottom.mas_equalTo(self.view.mas_bottom);
        make.width.offset(SCREEN_WIDTH);
    }];
    self.dataTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.dataTableView.backgroundColor = [CommonTools changeColor:@"0xECECEC"];
    NSString *cellClassName = NSStringFromClass([VBOrderManagerTableViewCell class]);
    [self tableRegisterNibName:cellClassName cellReuseIdentifier:cellClassName estimatedRowHeight:503];
    
    UIView *tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 15)];
    tableFooterView.backgroundColor = [UIColor clearColor];
    self.dataTableView.tableFooterView = tableFooterView;
}
#pragma mark tableView datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    VBOrderManagerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VBOrderManagerTableViewCell"];
    return cell;
}

#pragma mark tableview delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 503;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
