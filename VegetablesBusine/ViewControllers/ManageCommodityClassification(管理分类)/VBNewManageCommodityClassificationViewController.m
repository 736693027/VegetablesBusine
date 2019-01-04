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
#import "VBManageCommodityAddNewClassificationRequest.h"

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
    VBNewManageCommodityClassificationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VBNewManageCommodityClassificationTableViewCell"];
    VBManageCommodityClassificationModel *itemModel = [self.dataArray objectAtIndex:indexPath.row];
    cell.itemModel = itemModel;
    cell.deleteClassifySubject = [RACSubject subject];
    @weakify(self)
    [cell.deleteClassifySubject subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [self requestListData];
    }];
    cell.editingClassifySubject = [RACSubject subject];
    [cell.editingClassifySubject subscribeNext:^(id  _Nullable x) {
        VBAddCommodityClassificationView *addView = [VBAddCommodityClassificationView alterViewWithResult:^(NSString *name, NSString *number) {
            [SVProgressHUD show];
            VBManageCommodityAddNewClassificationRequest *request = [[VBManageCommodityAddNewClassificationRequest alloc] initWithClassificationId:itemModel.classifyID classificationName:name number:number];
            [request startRequestWithDicSuccess:^(NSDictionary *responseDic) {
                @strongify(self)
                [SVProgressHUD dismiss];
                [self requestListData];
            } failModel:^(LBResponseModel *errorModel) {
                [SVProgressHUD showErrorWithStatus:errorModel.message];
            } fail:^(YTKBaseRequest *request) {
                [SVProgressHUD showErrorWithStatus:@"更新失败"];
            }];
            NSLog(@"-----%@-----%@",name,number);
        }];
        addView.itemModel = itemModel;
        [addView show];
    }];
    cell.deleteClassifySubject = [RACSubject subject];
    [cell.deleteClassifySubject subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [self requestListData];
    }];
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
