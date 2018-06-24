//
//  XHStarRateView.m
//  XHStarRateView
//
//  Created by 江欣华 on 16/4/1.
//  Copyright © 2016年 jxh. All rights reserved.
//

#import "XHStarRateView.h"

#define ForegroundStarImage @"b27_icon_star_yellow"
#define BackgroundStarImage @"b27_icon_star_gray"

typedef void(^completeBlock)(CGFloat currentScore);

@interface XHStarRateView()

@property (nonatomic, strong) UIView *foregroundStarView;
@property (nonatomic, strong) UIView *backgroundStarView;

@property (nonatomic, assign) NSInteger numberOfStars;
@property (nonatomic,assign)CGFloat currentScore;   // 当前评分：0-5  默认0

@property (nonatomic,strong)completeBlock complete;

@end

@implementation XHStarRateView

static CGFloat starRateHeight = 12;
static CGFloat space = 5;

#pragma mark - 代理方式
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _numberOfStars = 5;
        _rateStyle = WholeStar;
        [self createStarView];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame numberOfStars:(NSInteger)numberOfStars rateStyle:(RateStyle)rateStyle isAnination:(BOOL)isAnimation delegate:(id)delegate{
    if (self = [super initWithFrame:frame]) {
        _numberOfStars = numberOfStars;
        _rateStyle = rateStyle;
        _isAnimation = isAnimation;
        _delegate = delegate;
        [self createStarView];
    }
    return self;
}

#pragma mark - block方式
-(instancetype)initWithFrame:(CGRect)frame finish:(finishBlock)finish{
    if (self = [super initWithFrame:frame]) {
        _numberOfStars = 5;
        _rateStyle = WholeStar;
        _complete = ^(CGFloat currentScore){
            finish(currentScore);
        };
        [self createStarView];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame numberOfStars:(NSInteger)numberOfStars rateStyle:(RateStyle)rateStyle isAnination:(BOOL)isAnimation finish:(finishBlock)finish{
    if (self = [super initWithFrame:frame]) {
        _numberOfStars = numberOfStars;
        _rateStyle = rateStyle;
        _isAnimation = isAnimation;
        _complete = ^(CGFloat currentScore){
            finish(currentScore);
        };
        [self createStarView];
    }
    return self;
}

#pragma mark - private Method
-(void)createStarView{
    
    self.foregroundStarView = [self createStarViewWithImage:ForegroundStarImage];
    self.backgroundStarView = [self createStarViewWithImage:BackgroundStarImage];
    NSInteger zhengshu = (NSInteger)self.currentScore;
    self.foregroundStarView.frame = CGRectMake(0, 0, zhengshu*(starRateHeight+space)+(self.currentScore - zhengshu)*starRateHeight, starRateHeight);
    
    [self addSubview:self.backgroundStarView];
    [self addSubview:self.foregroundStarView];
    
//    UIPanGestureRecognizer *tapGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(userTapRateView:)];
//    [self addGestureRecognizer:tapGesture];

}

- (UIView *)createStarViewWithImage:(NSString *)imageName {
    UIView *view = [[UIView alloc] initWithFrame:self.bounds];
    view.clipsToBounds = YES;
    view.backgroundColor = [UIColor clearColor];
    for (NSInteger i = 0; i < self.numberOfStars; i ++)
    {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
        imageView.frame = CGRectMake(((i*space)+(i*starRateHeight)), 0, starRateHeight, starRateHeight);
        [view addSubview:imageView];
    }
    return view;
}

- (void)setProgress:(CGFloat)progress{
    _progress = progress;
    self.currentScore = progress;
}
- (void)userTapRateView:(UITapGestureRecognizer *)gesture {
    CGPoint tapPoint = [gesture locationInView:self];
    CGFloat offset = tapPoint.x;
    CGFloat realStarScore = offset / (self.bounds.size.width / self.numberOfStars);
    switch (_rateStyle) {
        case WholeStar:
        {
            self.currentScore = ceilf(realStarScore);
            break;
        }
        case HalfStar:
            self.currentScore = roundf(realStarScore)>realStarScore ? ceilf(realStarScore):(ceilf(realStarScore)-0.5);
            break;
        case IncompleteStar:
            self.currentScore = realStarScore;
            break;
        default:
            break;
    }
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    __weak XHStarRateView *weakSelf = self;
    CGFloat animationTimeInterval = self.isAnimation ? 0.2 : 0;
    [UIView animateWithDuration:animationTimeInterval animations:^{
        NSInteger zhengshu = (NSInteger)weakSelf.progress;
        weakSelf.foregroundStarView.frame = CGRectMake(0, 0, zhengshu*(starRateHeight+space)+(weakSelf.progress - zhengshu)*starRateHeight, starRateHeight);
    }];
}


-(void)setCurrentScore:(CGFloat)currentScore {
    if (_currentScore == currentScore) {
        return;
    }
    if (currentScore < 0) {
        _currentScore = 0;
    } else if (currentScore > _numberOfStars) {
        _currentScore = _numberOfStars;
    } else {
        _currentScore = currentScore;
    }
    
    if ([self.delegate respondsToSelector:@selector(starRateView:currentScore:)]) {
        [self.delegate starRateView:self currentScore:_currentScore];
    }
    
    if (self.complete) {
        _complete(_currentScore);
    }
    
    [self setNeedsLayout];
}

@end
