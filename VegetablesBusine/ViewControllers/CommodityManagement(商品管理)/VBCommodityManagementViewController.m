//
//  VBCommodityManagementViewController.m
//  VegetablesBusine
//
//  Created by Apple on 2018/5/31.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "VBCommodityManagementViewController.h"
#import "VBMenuItemView.h"
#import "VBCommodityManagementTableViewCell.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import <Masonry/Masonry.h>
#import "VBManageCommodityClassificationViewController.h"

@interface VBCommodityManagementViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *menuScrollView;
@property (strong, nonatomic) NSArray *menuItemArray;
@property (assign, nonatomic) NSInteger currentItemIndex;
@property (strong, nonatomic) UILabel *tableHeaderTitlaLabel;

@end

@implementation VBCommodityManagementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商品管理";
    [self creatTableViewViewTableViewStyle:UITableViewStylePlain];
    [self.dataTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(84);
        make.bottom.offset(-54);
        make.top.right.offset(0);
    }];
    [self tableRegisterNibName:@"VBCommodityManagementTableViewCell" cellReuseIdentifier:@"VBCommodityManagementTableViewCell" estimatedRowHeight:143];
    _menuItemArray = @[@"新上架",@"食用油",@"限时打折\n促销商品"];
    _currentItemIndex = 0;
    for(NSInteger i=0;i<_menuItemArray.count;i++){
        NSString *itemString = [_menuItemArray objectAtIndex:i];
        VBMenuItemView *itemView = [[VBMenuItemView alloc] initWithFrame:CGRectMake(0, i*60, self.menuScrollView.frame.size.width, 60)];
        itemView.titleLabel.text = itemString;
        itemView.tag = i+100;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
        @weakify(self)
        [[tap rac_gestureSignal] subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
            @strongify(self)
            VBMenuItemView *itemView = (VBMenuItemView *)x.view;
            if(self.currentItemIndex != itemView.tag-100){
                itemView.controlState = UIControlStateSelected;
                VBMenuItemView *beformItemView = [self.menuScrollView viewWithTag:self.currentItemIndex+100];
                beformItemView.controlState = UIControlStateNormal;
                self.currentItemIndex = itemView.tag-100;
                self.tableHeaderTitlaLabel.text = [self.menuItemArray objectAtIndex:self.currentItemIndex];
            }
        }];
        [itemView addGestureRecognizer:tap];
        itemView.controlState = i==_currentItemIndex?UIControlStateSelected:UIControlStateNormal;
        [self.menuScrollView addSubview:itemView];
    }
    UIView *tableHeadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    self.tableHeaderTitlaLabel = [[UILabel alloc] init];
    [tableHeadView addSubview:self.tableHeaderTitlaLabel];
    self.tableHeaderTitlaLabel.font = [UIFont systemFontOfSize:14];
    self.tableHeaderTitlaLabel.text = _menuItemArray[0];
    [self.tableHeaderTitlaLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset(10);
    }];
    self.dataTableView.tableHeaderView = tableHeadView;
}

#pragma mark tableview datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 143;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    VBCommodityManagementTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VBCommodityManagementTableViewCell"];
    return cell;
}
- (IBAction)managerButtonClick:(id)sender {
    VBManageCommodityClassificationViewController *managerVC = [[VBManageCommodityClassificationViewController alloc] init];
    [self.navigationController pushViewController:managerVC animated:YES];
}
- (IBAction)addButtonClick:(id)sender {
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
