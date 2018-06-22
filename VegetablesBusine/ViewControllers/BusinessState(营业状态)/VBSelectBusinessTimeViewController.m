//
//  VBSelectBusinessTimeViewController.m
//  VegetablesBusine
//
//  Created by Apple on 2018/6/21.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "VBSelectBusinessTimeViewController.h"
#import "BusinessTimeView.h"
#import <Masonry/Masonry.h>

@interface VBSelectBusinessTimeViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollview;

@end

@implementation VBSelectBusinessTimeViewController
- (void)navRightButtonClicked:(UIButton *)sender{
    sender.selected = !sender.selected;
    for(NSInteger i=0;i<50;i++){
        BusinessTimeView * itemTimeView = [self.mainScrollview viewWithTag:i+100];
        itemTimeView.selectState = !itemTimeView.selectState;
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [navRrightBtn setImage:[UIImage imageNamed:@"checkbox1_checked"] forState:UIControlStateNormal];
    [navRrightBtn setImage:[UIImage imageNamed:@"checkbox1_unchecked"] forState:UIControlStateSelected];
    [navRrightBtn setTitle:@"全选" forState:UIControlStateNormal];
    [navRrightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [navRrightBtn setTitle:@"全选" forState:UIControlStateSelected];
    [navRrightBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 5)];
    [navRrightBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
    [navRrightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [navRrightBtn setFrame:CGRectMake(0, 0, 80, 30)];
    navRrightBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    
    self.title = @"选择配送时间";
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    [self.mainScrollview addSubview:titleView];
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.textColor = [CommonTools changeColor:@"0xa2a2a2"];
    titleLabel.font = [UIFont systemFontOfSize:12];
    titleLabel.text = @"请在下列时间表点击选择配送时间，再次点击取消选择";
    [titleView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(12);
        make.left.offset(10);
        make.right.offset(-10);
        make.bottom.offset(-12);
    }];
    
    CGFloat width = (SCREEN_WIDTH - 4*10)/3;
    NSInteger row = (50%3==(0))?(50/3):(50/3+1);
    self.mainScrollview.contentSize = CGSizeMake(SCREEN_WIDTH, row*50+row*10+40);
    for(NSInteger i=0;i<50;i++){
        BusinessTimeView * itemTimeView = [[[NSBundle mainBundle] loadNibNamed:@"BusinessTimeView" owner:self options:nil] lastObject];
        itemTimeView.frame = CGRectMake(10*((i%3)+1)+(i%3)*width, 40+10*(i/3)+(i/3)*50, width, 50);
        itemTimeView.tag = i+100;
        [self.mainScrollview addSubview:itemTimeView];
    }
}
- (IBAction)submitButtonClick:(UIButton *)sender {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
