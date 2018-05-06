//
//  BaseTableViewController.m
//  zhxf
//
//  Created by BG on 2017/7/27.
//  Copyright © 2017年 app. All rights reserved.
//

#import "BaseTableViewController.h"
#import "MJRefresh.h"

@interface BaseTableViewController ()

@end

@implementation BaseTableViewController

- (UIImage *)emptyImage{
    if(_emptyImage == nil){
        _emptyImage = [UIImage imageNamed:@"icon_noNews"];
    }
    return _emptyImage;
}
- (NSString *)emptyPlaceHolderString{
    if(_emptyPlaceHolderString == nil){
        _emptyPlaceHolderString = @"暂无数据~";
    }
    return _emptyPlaceHolderString;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataArray = [[NSMutableArray alloc] init];
    _dataTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
    [_dataTableView setTableFooterView:[UIView new]];
    _dataTableView.delegate = self;
    _dataTableView.dataSource = self;
    _dataTableView.emptyDataSetDelegate = self;
    _dataTableView.emptyDataSetSource = self;
    [self.view addSubview:self.dataTableView];
    _dataTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(tableHeadViewRefreshAction)];
    _dataTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(tableFootViewRefreshAction)];
}

- (void)tableRegisterNibName:(NSString *)nibName cellReuseIdentifier:(NSString *)cellReuseIdentifier estimatedRowHeight:(CGFloat)height{
    self.dataTableView.rowHeight = UITableViewAutomaticDimension;
    self.dataTableView.estimatedRowHeight = height;
    [self.dataTableView registerNib:[UINib nibWithNibName:nibName bundle:nil] forCellReuseIdentifier:cellReuseIdentifier];
}

- (void)tableHeadViewRefreshAction{
};

- (void)tableFootViewRefreshAction{
};

- (void)setIsClickEmptyImageLoading:(BOOL)isClickEmptyImageLoading
{
    if (self.isClickEmptyImageLoading == isClickEmptyImageLoading) {
        return;
    }
    
    _isClickEmptyImageLoading = isClickEmptyImageLoading;
    
    [self.dataTableView reloadEmptyDataSet];
}

#pragma mark tableView datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    UIFont *font = [UIFont boldSystemFontOfSize:14.0];
    UIColor *textColor = [CommonTools changeColor:@"#cccccc"];
    
    [attributes setObject:font forKey:NSFontAttributeName];
    [attributes setObject:textColor forKey:NSForegroundColorAttributeName];
    
    return [[NSAttributedString alloc] initWithString:self.emptyPlaceHolderString attributes:attributes];
}
- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView{
//    NSString *text = nil;
//    UIFont *font = nil;
//    UIColor *textColor = nil;
//    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
//    text = @"点击重试";
//    font = [UIFont boldSystemFontOfSize:13.0];
//    textColor = [UIColor cyanColor];
//    
//    [attributes setObject:font forKey:NSFontAttributeName];
//    [attributes setObject:textColor forKey:NSForegroundColorAttributeName];
//    
//    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
    return nil;
}
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    if(self.isClickEmptyImageLoading){
        return [UIImage imageNamed:@"icon_noNews"];
    }else{
        return self.emptyImage;
    }
}
- (CAAnimation *)imageAnimationForEmptyDataSet:(UIScrollView *)scrollView{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    animation.toValue = [NSValue valueWithCATransform3D: CATransform3DMakeRotation(M_PI_2, 0.0, 0.0, 1.0) ];
    animation.duration = 0.25;
    animation.cumulative = YES;
    animation.repeatCount = MAXFLOAT;
    
    return animation;
}
- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView{
    return 10;
}
- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView{
    return 0;
}
#pragma mark - DZNEmptyDataSetDelegate Methods

- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView
{
    return YES;
}

- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView
{
    return YES;
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView
{
    return YES;
}

- (BOOL)emptyDataSetShouldAnimateImageView:(UIScrollView *)scrollView
{
    return self.isClickEmptyImageLoading;
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view
{
//    self.isClickEmptyImageLoading = YES;
//    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        self.isClickEmptyImageLoading = NO;
//    });
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button
{
//    self.isClickEmptyImageLoading = YES;
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        self.isClickEmptyImageLoading = NO;
//    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
