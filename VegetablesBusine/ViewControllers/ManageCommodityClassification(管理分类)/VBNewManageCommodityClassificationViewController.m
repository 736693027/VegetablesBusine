//
//  VBNewManageCommodityClassificationViewController.m
//  
//
//  Created by 刘少轩 on 2018/6/27.
//

#import "VBNewManageCommodityClassificationViewController.h"
#import "VBNewManageCommodityClassificationTableViewCell.h"
#import "VBAddCommodityClassificationView.h"
#import "VBManageCommodityClassificationRequest.h"
#import "VBManageCommodityClassificationModel.h"

@interface VBNewManageCommodityClassificationViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *dataTableView;
@property (copy, nonatomic) NSArray *dataArray;

@end

@implementation VBNewManageCommodityClassificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商品分类";
    self.dataArray = [NSArray array];
    [self.dataTableView registerNib:[UINib nibWithNibName:@"VBNewManageCommodityClassificationTableViewCell" bundle:nil] forCellReuseIdentifier:@"VBNewManageCommodityClassificationTableViewCell"];
    self.dataTableView.tableFooterView = [UIView new];
    [SVProgressHUD show];
    VBManageCommodityClassificationRequest *requset = [[VBManageCommodityClassificationRequest alloc] init];
    [requset startRequestWithArraySuccess:^(NSArray *responseArray) {
        self.dataArray = [NSArray yy_modelArrayWithClass:[VBManageCommodityClassificationModel class] json:responseArray];
        [self.dataTableView reloadData];
    } failModel:^(LBResponseModel *errorModel) {
        [SVProgressHUD showErrorWithStatus:errorModel.message];
    } fail:^(YTKBaseRequest *request) {
        [SVProgressHUD showErrorWithStatus:@"分类获取失败"];
    }];
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
    VBNewManageCommodityClassificationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VBNewManageCommodityClassificationTableViewCell"];
    VBManageCommodityClassificationModel *itemModel = [self.dataArray objectAtIndex:indexPath.row];
    cell.itemModel = itemModel;
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
