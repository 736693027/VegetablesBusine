//
//  VBNewManageCommodityClassificationViewController.m
//  
//
//  Created by 刘少轩 on 2018/6/27.
//

#import "VBNewManageCommodityClassificationViewController.h"
#import "VBNewManageCommodityClassificationTableViewCell.h"
#import "VBAddCommodityClassificationView.h"

@interface VBNewManageCommodityClassificationViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *dataTableView;

@end

@implementation VBNewManageCommodityClassificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商品分类";
    [self.dataTableView registerNib:[UINib nibWithNibName:@"VBNewManageCommodityClassificationTableViewCell" bundle:nil] forCellReuseIdentifier:@"VBNewManageCommodityClassificationTableViewCell"];
    self.dataTableView.tableFooterView = [UIView new];
}
- (IBAction)addNewCommodityClassifcationAction:(UITapGestureRecognizer *)sender {
    VBAddCommodityClassificationView *addView = [VBAddCommodityClassificationView alterViewWithResult:^(NSString *name, NSString *number) {
        NSLog(@"-----%@-----%@",name,number);
    }];
    [addView show];
}

#pragma mark tableview datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    VBNewManageCommodityClassificationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VBNewManageCommodityClassificationTableViewCell"];
    return cell;
}

#pragma mark tableview delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80.f;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
