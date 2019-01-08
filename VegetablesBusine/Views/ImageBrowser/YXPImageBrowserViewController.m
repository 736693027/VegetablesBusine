//
//  YXPImageBrowserViewController.m
//  YXPSeller-iPhone
//
//  Created by zhaojunwei on 1/12/15.
//  Copyright (c) 2015 youxinpai. All rights reserved.
//

#import "YXPImageBrowserViewController.h"
#import "YXPImageBrowserLayout.h"
#import "YXPImageBrowserConstants.h"
#import "YXPImageBrowserCell.h"
#import "LBBrowserContentView.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import <Masonry/Masonry.h>

@interface YXPImageBrowserViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate>

@property (nonatomic, retain) YXPImageBrowserLayout *browserLayout;
@property (nonatomic, retain) UICollectionView *collectionView;
@property (nonatomic, retain) NSMutableArray *images;
@property (nonatomic, retain) NSArray *titles;

@property (nonatomic, strong) UILabel * currentIndexLabel;
@property (nonatomic, strong) LBBrowserContentView * browserContentView;
@property (nonatomic, strong) UIButton * backupButton;

@end

static NSString *YXPImageBrowserCellItemIdentifier = @"YXPImageBrowserCellItemIdentifier";

@implementation YXPImageBrowserViewController

-(void)dealloc {
    [self removeNotificationObserver];
    NSLog(@"image browser dealloc");
}

- (instancetype)initWithImageUrls:(NSArray <__kindof NSString *> *)imageUrls
                      imageTitles:(NSArray <__kindof NSString *>*)imageTitles {
    self = [super init];
    if (self){
        
        NSMutableArray <__kindof NSURL *>*URLs = [NSMutableArray array];
        
        [imageUrls enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSString *encodeString = [obj stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            NSURL *imageURL = [NSURL URLWithString:encodeString];
            if (imageURL != nil) {
                [URLs addObject:imageURL];
            }
        }];

        if (URLs.count == 0) {
            //先看titles是否为空
            if (imageTitles.count > 0) {
                for (NSInteger i = 0; i < imageTitles.count; i ++) {
                    [URLs addObject:[NSURL URLWithString:@"http://"]];
                }
            } else {
                [URLs addObject:[NSURL URLWithString:@"http://"]];
            }
        }
        
        self.images = [NSMutableArray arrayWithArray:URLs];
        self.titles = imageTitles;
        _currentIndex = 0;
    }
    return self;
}

- (instancetype)initWithImages:(NSArray <__kindof UIImage *>*)images
                   imageTitles:(NSArray <__kindof NSString *>*)imageTitles {
    self = [super init];
    if (self){
        self.images = [NSMutableArray arrayWithArray:images];
        self.titles = imageTitles;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    [self updateIndexText];
    [self scrollToCurrentIndexAnimated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
        [self setAutomaticallyAdjustsScrollViewInsets:NO];
    }
    
    self.view.backgroundColor = k_YXPIB_BGColor;
    
    [self createSubviews];
    
    [self addBackBtn];
    
    [self addNotificationObserver];
    
//    if ([_titles count] > 0){
//        if ([NSString stringWithFormat:@"%@",[_titles objectAtIndex:0]].length != 0){
//            self.browserContentView.hidden = NO;
//        }else{
//            self.browserContentView.hidden = YES;
//        }
//    }
    if(_titles.count > 0){
        if(_titles.count > _currentIndex && [NSString stringWithFormat:@"%@",[_titles objectAtIndex:_currentIndex]].length != 0){
            self.browserContentView.hidden = NO;
        }else{
            self.browserContentView.hidden = YES;
        }
    }else{
        self.browserContentView.hidden = YES;
    }
}

- (void)addBackBtn{
    _backupButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backupButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    _backupButton.frame = CGRectMake(0, 20, 44, 44);
    [_backupButton setBackgroundColor:[UIColor clearColor]];
    [_backupButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:_backupButton];
    
//    if(self.isShowDownLoadButton){
//        UIButton *downloadButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        UIImage *image = [UIImage imageNamed:@"YXPImage_download_icon"];
//        [downloadButton setImage:image forState:UIControlStateNormal];
//        [downloadButton setBackgroundColor:[UIColor clearColor]];
//        [self.view addSubview:downloadButton];
//        [downloadButton mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.width.offset(image.size.width);
//            make.height.offset(image.size.height);
//            make.bottom.right.offset(-25);
//        }];
//        @weakify(self)
//        [[downloadButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
//            @strongify(self);
//            NSString *imageString = [self.images objectAtIndex:self.currentIndex];
//            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//                NSURL *imageUrl = [NSURL URLWithString:imageString];
//                
//            })
//        }];
//    }
}

- (void)back:(id)sender{
    [self closeAction];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Public

- (void)setPageIndex:(NSUInteger)index {
    // validate
    NSUInteger photoCount = self.images.count;
    if (photoCount == 0) {
        index = 0;
    } else {
        if (index >= photoCount) {
            index = self.images.count - 1;
        }
    }
    _currentIndex = index;
}

#pragma mark - Action

- (void)closeAction {
    if ([self.delegate respondsToSelector:@selector(dismissAtIndex:)]) {
        [self.delegate dismissAtIndex:self.currentIndex];
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)hiddenDescription{
    __weak typeof(self) weakSelf = self;

    if(weakSelf.backupButton.hidden){
        [UIView animateWithDuration:0.2 animations:^{
            weakSelf.backupButton.hidden = NO;
            weakSelf.currentIndexLabel.hidden = NO;
        }];
    }else{
        [UIView animateWithDuration:0.2 animations:^{
            weakSelf.backupButton.hidden = YES;
            weakSelf.currentIndexLabel.hidden = YES;
        }];
    }
    
    if ([NSString stringWithFormat:@"%@",[weakSelf.titles objectAtIndex:weakSelf.currentIndex]].length == 0){
        weakSelf.browserContentView.hidden = YES;
        return ;
    }
    
    if(weakSelf.browserContentView.hidden){
        [UIView animateWithDuration:0.2 animations:^{
            weakSelf.browserContentView.frame = CGRectMake(0, SCREEN_HEIGHT - weakSelf.browserContentView.height, weakSelf.browserContentView.width, weakSelf.browserContentView.height);
            weakSelf.browserContentView.hidden = NO;
        }];
    }else{
        
        [UIView animateWithDuration:0.2 animations:^{
            weakSelf.browserContentView.frame = CGRectMake(0, SCREEN_HEIGHT , weakSelf.browserContentView.width, weakSelf.browserContentView.height);
        } completion:^(BOOL finished) {
            weakSelf.browserContentView.hidden = YES;
        }];
    }
}

#pragma mark - Private

- (void)updateIndexText {
    if (self.currentIndex >= self.titles.count) {
        return;
    }
    __weak typeof(self) weakSelf = self;

    if(_titles.count > 0){
        if(_titles.count > _currentIndex && [NSString stringWithFormat:@"%@",[_titles objectAtIndex:_currentIndex]].length != 0){
            [UIView animateWithDuration:1.0 animations:^{
                self.browserContentView.hidden = NO;
            }];
        }else{
            [UIView animateWithDuration:1.0 animations:^{
                self.browserContentView.hidden = YES;
            }];
        }
    }
    
    self.currentIndexLabel.text = [NSString stringWithFormat:@"%ld/%ld",self.currentIndex + 1,[self.titles count]];
    
    CGSize size = [CommonTools boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 20, 0) font:[UIFont systemFontOfSize:15.0] text:[_titles objectAtIndex:self.currentIndex]];
    
    CGFloat offset = (size.height + 20);
    
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.browserContentView.frame = CGRectMake(0, SCREEN_HEIGHT - (offset>100 ? 100: offset), SCREEN_WIDTH, offset);
    }];
    
    self.browserContentView.handleDirenctionBlock = ^(UISwipeGestureRecognizerDirection direction){
        if (direction == UISwipeGestureRecognizerDirectionUp){
            [UIView animateWithDuration:0.3 animations:^{
                weakSelf.browserContentView.frame = CGRectMake(0, SCREEN_HEIGHT - offset, SCREEN_WIDTH, offset);
            }];
        }else{
            [UIView animateWithDuration:0.3 animations:^{
                weakSelf.browserContentView.frame = CGRectMake(0, SCREEN_HEIGHT - (offset>100 ? 100: offset), SCREEN_WIDTH, offset);
            }];
        }
    };
    self.browserContentView.text = [_titles objectAtIndex:self.currentIndex];
}

- (void)scrollToCurrentIndexByCurrentSize:(CGSize)size animated:(BOOL)animated {
    CGFloat contentOffset_x = self.currentIndex * (size.width + YXPIB_PageGap);
    CGPoint point = CGPointMake(contentOffset_x, 0);
    [self.collectionView setContentOffset:point animated:animated];
}

- (void)scrollToCurrentIndexAnimated:(BOOL)animated {
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.currentIndex inSection:0]
                                atScrollPosition:UICollectionViewScrollPositionLeft animated:animated];
}

#pragma mark -

- (void)createSubviews {
    CGRect rect = CGRectMake(0.0f,
                             0.0f,
                             self.view.bounds.size.width + YXPIB_PageGap,
                             self.view.bounds.size.height);
    
    self.browserLayout = [[YXPImageBrowserLayout alloc] initWithItemSize:self.view.bounds.size];
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:rect
                                             collectionViewLayout:self.browserLayout];
    
    [self.collectionView registerClass:[YXPImageBrowserCell class]
            forCellWithReuseIdentifier:YXPImageBrowserCellItemIdentifier];
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.alpha = 1.0f;
    self.collectionView.hidden = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.backgroundColor = k_YXPIB_BGColor;
    [self.view addSubview:self.collectionView];

    self.currentIndexLabel = [[UILabel alloc] init];
    self.currentIndexLabel.frame = CGRectMake(0, 20, SCREEN_WIDTH, 44);
    self.currentIndexLabel.backgroundColor = [UIColor clearColor];
    self.currentIndexLabel.font = [UIFont systemFontOfSize:15.0];
    self.currentIndexLabel.textAlignment = NSTextAlignmentCenter;
    self.currentIndexLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:self.currentIndexLabel];
    
    self.browserContentView = [[LBBrowserContentView alloc] initWithTableViewHeight:80];
    self.browserContentView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 0);
    self.browserContentView.backgroundColor = [UIColor grayColor];
    self.browserContentView.alpha = 0.6;
    [self.view addSubview:self.browserContentView];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // Calculate current page
    CGRect visibleBounds = scrollView.bounds;
    NSInteger index = (NSInteger)(floorf(CGRectGetMidX(visibleBounds) / CGRectGetWidth(visibleBounds)));
    if (index < 0) {
        index = 0;
    }
    if (index > self.images.count - 1) {
        index = self.images.count - 1;
    }
    _currentIndex = index;
    [self updateIndexText];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger index=scrollView.contentOffset.x/SCREEN_WIDTH;
    
    if (self.didScrollToIndexBlock) {
        self.didScrollToIndexBlock(index);
    }
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView
    numberOfItemsInSection:(NSInteger)section {
    return self.images.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                 cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YXPImageBrowserCell *cell =
    (YXPImageBrowserCell *)[collectionView dequeueReusableCellWithReuseIdentifier:YXPImageBrowserCellItemIdentifier
                                                                     forIndexPath:indexPath];
    if (indexPath.section == 0) {
        cell.isShowSaveImageButton = self.isShowDownLoadButton;
        cell.imageBrowser = self;
        id obj = self.images[indexPath.item];
        [cell configCellImageObj:obj
                inCollectionView:collectionView
                     atIndexPath:indexPath];
        
    }
    
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"tap item at index=%ld",indexPath.row);
}

- (void)addNotificationObserver {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hiddenDescription) name:YXPIBU_SingleTapNotificationName object:nil];
}

- (void)removeNotificationObserver {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
