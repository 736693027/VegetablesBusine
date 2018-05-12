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

CGFloat itemViewHeight = 110;

@interface VBShoppingManagerViewController ()
@property (weak, nonatomic) IBOutlet UIView *itemContentView;

@end

@implementation VBShoppingManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
            NSLog(@"--------->>>%ld",index);
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
