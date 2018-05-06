//
//  BaseTableViewController.h
//  zhxf
//
//  Created by BG on 2017/7/27.
//  Copyright © 2017年 app. All rights reserved.
//

#import "BaseViewController.h"
#import "UIScrollView+EmptyDataSet.h"

@interface BaseTableViewController : BaseViewController<DZNEmptyDataSetSource,DZNEmptyDataSetDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *dataArray; //数据源
@property (assign, nonatomic) BOOL isClickEmptyImageLoading;//是否点击图标加载数据
@property (nonatomic, strong) UITableView *dataTableView;
@property (nonatomic, strong) UIImage *emptyImage;
@property (nonatomic, copy) NSString *emptyPlaceHolderString;

- (void)tableHeadViewRefreshAction;
- (void)tableFootViewRefreshAction;

- (void)tableRegisterNibName:(NSString *)nibName cellReuseIdentifier:(NSString *)CellReuseIdentifier estimatedRowHeight:(CGFloat)height;

@end
