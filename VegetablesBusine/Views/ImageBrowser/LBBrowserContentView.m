//
//  LBBrowserContentView.m
//  LBAssistant
//
//  Created by zhengjunchao on 16/5/9.
//  Copyright © 2016年 FSLB. All rights reserved.
//

#import "LBBrowserContentView.h"

@interface LBBrowserContentView (){
    
}
@property (nonatomic, assign) CGFloat tableViewHeight;
@property (nonatomic, strong) UILabel * contentView;

@end

@implementation LBBrowserContentView

- (instancetype)initWithTableViewHeight:(CGFloat)height {
    self = [super init];
    if (self){
        _tableViewHeight = height;

        _contentView = [[UILabel alloc] init];
        _contentView.frame = CGRectMake(10, 0, SCREEN_WIDTH - 20, height);
        _contentView.numberOfLines = 0;
        _contentView.font = [UIFont systemFontOfSize:15.0];
        _contentView.backgroundColor = [UIColor clearColor];
        _contentView.textColor = [UIColor whiteColor];
        [self addSubview:_contentView];

        UISwipeGestureRecognizer * recongzier;
        recongzier = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
        [recongzier setDirection:UISwipeGestureRecognizerDirectionUp];
        [self addGestureRecognizer:recongzier];
        
        recongzier = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
        [recongzier setDirection:UISwipeGestureRecognizerDirectionDown];
        [self addGestureRecognizer:recongzier];

    }
    return self;
}

- (void)handleSwipeFrom:(UISwipeGestureRecognizer *)recongzier {
    if (_handleDirenctionBlock){
        _handleDirenctionBlock(recongzier.direction);
    }
}

- (void)setText:(NSString *)text {
    _text = text;
    
    CGSize size = [CommonTools boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 20, 0) font:[UIFont systemFontOfSize:15.0] text:text];
    
    _contentView.text = text;
    if (text.length != 0){
        _contentView.hidden = NO;
    }else{
        _contentView.hidden = YES;
    }
    _contentView.frame = CGRectMake(10, 0, SCREEN_WIDTH - 20, size.height + 20);
}


@end
