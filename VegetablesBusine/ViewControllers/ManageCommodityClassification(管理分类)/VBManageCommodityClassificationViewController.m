//
//  VBManageCommodityClassificationViewController.m
//  
//
//  Created by 刘少轩 on 2018/6/27.
//

#import "VBManageCommodityClassificationViewController.h"
#import "VBManageCommodityClassificationTableViewCell.h"
#import "VBAddCommodityClassificationView.h"

@interface VBManageCommodityClassificationViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *dataTableView;
@property (copy, nonatomic) NSArray *dataArray;
@end

@implementation VBManageCommodityClassificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商品分类";
    self.dataArray = [NSArray array];
    [self.dataTableView registerNib:[UINib nibWithNibName:@"VBManageCommodityClassificationTableViewCell" bundle:nil] forCellReuseIdentifier:@"VBManageCommodityClassificationTableViewCell"];
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
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    VBManageCommodityClassificationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VBManageCommodityClassificationTableViewCell"];
    return cell;
}

#pragma mark tableview delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 39.f;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
