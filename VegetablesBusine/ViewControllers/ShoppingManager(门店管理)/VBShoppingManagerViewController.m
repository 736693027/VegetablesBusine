//
//  VBShoppingManagerViewController.m
//  VegetablesBusine
//
//  Created by Apple on 2018/5/12.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "VBShoppingManagerViewController.h"
#import "VBShoppingManagerMenuItemView.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import "VBShoppingManangerDetailAPI.h"

CGFloat itemViewHeight = 110;

@interface VBShoppingManagerViewController ()
@property (weak, nonatomic) IBOutlet UIView *itemContentView;
@property (weak, nonatomic) IBOutlet UILabel *currentDayBusinessLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *accountBalanceLabel;

@end

@implementation VBShoppingManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    VBShoppingManangerDetailAPI *requestAPI = [[VBShoppingManangerDetailAPI alloc] init];
    [requestAPI startRequestWithDicSuccess:^(NSDictionary *responseDic) {
        self.currentDayBusinessLabel.text = [responseDic objectForKey:@"currentDayBusiness"];
        self.totalCountLabel.text = [responseDic objectForKey:@"totalCount"];
        self.accountBalanceLabel.text = [responseDic objectForKey:@"accountBalance"];
    } failModel:^(LBResponseModel *errorModel) {
        [SVProgressHUD showErrorWithStatus:errorModel.message];
    } fail:^(YTKBaseRequest *request) {
        [SVProgressHUD showErrorWithStatus:@"门店信息初始化失败"];
    }];

    NSArray *titlesArray = @[@"商品管理",@"商家结算",@"店铺统计",@"留言评价",@"打印机",@"促销管理",@"闪惠订单",@""];
    NSArray *imagesArray = @[@"productManagex",@"bigCalculatorx",@"productCountx",@"evaluatex",@"printSettingx",@"promotionx",@"shanhuiOrderx",@""];
    NSArray *detailsArray = @[@"支持商品一件发布",@"查询余额体现",@"插件店铺收益",@"查看最新留言",@"连接打印机",@"发布促销信息",@"闪惠订单管理",@""];
    
    for(NSInteger i=0;i<titlesArray.count;i++){
        VBShoppingManagerMenuItemView *itemView = [[[NSBundle mainBundle] loadNibNamed:@"VBShoppingManagerMenuItemView" owner:self options:nil] lastObject];
        [itemView.iconImageView setImage:[UIImage imageNamed:imagesArray[i]]];
        itemView.titleLabel.text = titlesArray[i];
        itemView.detailLabel.text = detailsArray[i];
        NSInteger setion = i/4;
        NSInteger row = i%4;
        itemView.frame = CGRectMake(row*(SCREEN_WIDTH/4), setion*itemViewHeight, SCREEN_WIDTH/4, itemViewHeight);
        itemView.tag = i;
        [self.itemContentView addSubview:itemView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
        [[tap rac_gestureSignal] subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
            NSInteger index = x.view.tag;
            Class viewControClass = nil;
            switch (index) {
                case 0:{
                    viewControClass = NSClassFromString(@"VBCommodityManagementViewController");
                }
                     break;
                case 1:{
                    viewControClass = NSClassFromString(@"VBMerchantSettlementViewController");
                }
                    break;
                case 2:{
                    viewControClass = NSClassFromString(@"VBBusinessStatisticsViewController");
                }
                    break;
                case 3:{
                    viewControClass = NSClassFromString(@"VBEvaluationViewController");
                }
                    break;
                case 4:{
                    viewControClass = NSClassFromString(@"VBPrinterSetupViewController");
                }
                    break;
                case 5:{
                    viewControClass = NSClassFromString(@"VBFavourableActivityViewController");
                }
                    break;
                case 6:{
                    viewControClass = NSClassFromString(@"VBFavourableOrderViewController");
                }
                    break;
                default:
                    break;
            }
            UIViewController *vc = [[viewControClass alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }];
        [itemView addGestureRecognizer:tap];
    }
    
    //footerView
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, itemViewHeight*2, SCREEN_WIDTH, 45)];
    footerView.backgroundColor = [UIColor whiteColor];
    [self.itemContentView addSubview:footerView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
