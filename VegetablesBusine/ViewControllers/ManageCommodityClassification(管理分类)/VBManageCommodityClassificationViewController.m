//
//  VBManageCommodityClassificationViewController.m
//  
//
//  Created by 刘少轩 on 2018/6/27.
//

#import "VBManageCommodityClassificationViewController.h"
#import "VBManageCommodityClassificationTableViewCell.h"
#import "VBAddCommodityClassificationView.h"
#import "VBManageCommodityClassificationRequest.h"
#import "VBManageCommodityClassificationModel.h"
#import "VBManageCommodityAddNewClassificationRequest.h"

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
    [self requestListData];
}
- (void)requestListData{
    [SVProgressHUD show];
    VBManageCommodityClassificationRequest *requset = [[VBManageCommodityClassificationRequest alloc] init];
    [requset startRequestWithArraySuccess:^(NSArray *responseArray) {
        [SVProgressHUD dismiss];
        self.dataArray = [NSArray yy_modelArrayWithClass:[VBManageCommodityClassificationModel class] json:responseArray];
        [self.dataTableView reloadData];
    } failModel:^(LBResponseModel *errorModel) {
        [SVProgressHUD showErrorWithStatus:errorModel.message];
    } fail:^(YTKBaseRequest *request) {
        [SVProgressHUD showErrorWithStatus:@"分类获取失败"];
    }];
}
- (IBAction)addNewCommodityClassifcationAction:(UITapGestureRecognizer *)sender {
    @weakify(self)
    VBAddCommodityClassificationView *addView = [VBAddCommodityClassificationView alterViewWithResult:^(NSString *name, NSString *number) {
        [SVProgressHUD show];
        VBManageCommodityAddNewClassificationRequest *request = [[VBManageCommodityAddNewClassificationRequest alloc] initWithClassificationId:@"" classificationName:name number:number];
        [request startRequestWithDicSuccess:^(NSDictionary *responseDic) {
            @strongify(self)
            [SVProgressHUD dismiss];
            [self requestListData];
        } failModel:^(LBResponseModel *errorModel) {
            [SVProgressHUD showErrorWithStatus:errorModel.message];
        } fail:^(YTKBaseRequest *request) {
            [SVProgressHUD showErrorWithStatus:@"更新失败"];
        }];
    }];
    [addView show];
}

#pragma mark tableview datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    VBManageCommodityClassificationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VBManageCommodityClassificationTableViewCell"];
    VBManageCommodityClassificationModel *itemModel = [self.dataArray objectAtIndex:indexPath.row];
    cell.itemModel = itemModel;
    return cell;
}

#pragma mark tableview delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 39.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    VBManageCommodityClassificationModel *itemModel = [self.dataArray objectAtIndex:indexPath.row];
    if(self.didSelectItemSubject){
        [self.didSelectItemSubject sendNext:itemModel];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
