//
//  CustomerTabBarView.m
//  VegetableManagement
//
//  Created by Apple on 2018/3/30.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "CustomerTabBarView.h"
#import "VMTabBarView.h"

@implementation CustomerTabBarView

- (void)awakeFromNib{
    [super awakeFromNib];
    _selectIndex = 0;
    NSArray *titleArray = @[@"待处理",@"订单管理",@"门店管理",@"设置"];
    NSArray *imageArray = @[@"pendingIconOnx",@"orderManagementOffIconx",@"shopManagementOffIconx",@"shopSettingOffIconx"];
    for(NSInteger i=0;i<titleArray.count;i++){
        VMTabBarView *tabBarView = [self viewWithTag:i+10000];
        tabBarView.titleLabel.text = [titleArray objectAtIndex:i];
        tabBarView.titleLabel.textColor = [CommonTools changeColor:@"0x666666"];
        [tabBarView.iconImageView setImage:[UIImage imageNamed:imageArray[i]]];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectItemGesture:)];
        [tabBarView addGestureRecognizer:tap];
    }
}
- (void)setSelectIndex:(NSInteger)selectIndex
{
    if(selectIndex<0)
        selectIndex = 0;
    else if (selectIndex>3)
        selectIndex = 3;
    
    if(_selectIndex != selectIndex){
        [self setupTabBarItemfrom:_selectIndex next:selectIndex];
        _selectIndex = selectIndex;
    }
}

- (void)setupTabBarItemfrom:(NSInteger)beforIndex next:(NSInteger)nextIndex{
    
    NSArray *imageArray = @[@"pendingIconOffx",@"orderManagementOffIconx",@"shopManagementOffIconx",@"shopSettingOffIconx"];
    NSArray *selectImageArray = @[@"pendingIconOnx",@"orderManagementOnIconx",@"shopManagementOnIconx",@"shopSettingOnIconx"];
    // 先把上次选择的item设置为可用
    VMTabBarView *beforTabBarView = [self viewWithTag:beforIndex+10000];
    [beforTabBarView.iconImageView setImage:[UIImage imageNamed:imageArray[beforIndex]]];
    NSString *beforTitleLabelString = beforTabBarView.titleLabel.text;
    NSMutableAttributedString *beforAttributedString = [self setupTabBarItemTitle:beforTitleLabelString state:NO];
    [beforTabBarView.titleLabel setAttributedText:beforAttributedString];
    
    // 再把这次选择的item设置为不可用
    VMTabBarView *nextTabBarView = [self viewWithTag:nextIndex+10000];
    [nextTabBarView.iconImageView setImage:[UIImage imageNamed:selectImageArray[nextIndex]]];
    NSString *nextTitleLabelString = nextTabBarView.titleLabel.text;
    NSMutableAttributedString *nextAttributedString = [self setupTabBarItemTitle:nextTitleLabelString state:YES];
    [nextTabBarView.titleLabel setAttributedText:nextAttributedString];
}
- (IBAction)selectItemGesture:(UITapGestureRecognizer *)sender {
    self.selectIndex = sender.view.tag - 10000;
    // 让代理来处理切换viewController的操作
    if ([self.viewDelegate respondsToSelector:@selector(msTabBarView:didSelectItemAtIndex:)]) {
        [self.viewDelegate msTabBarView:self didSelectItemAtIndex:self.selectIndex];
    }
}

- (NSMutableAttributedString *)setupTabBarItemTitle:(NSString *)titleString state:(BOOL)isSelect{
    NSString *bridgeString = @"";
    if([titleString containsString:@"("]){
        NSRange range = [titleString rangeOfString:@"("];
        NSRange lastRangr = [titleString rangeOfString:@")"];
        bridgeString = [titleString substringWithRange:NSMakeRange(range.location, lastRangr.location-range.location)];
    }
    NSMutableAttributedString *attributedString;
    if(!isSelect){
        attributedString = [[NSMutableAttributedString alloc] initWithString:titleString];
        [attributedString setAttributes:@{NSForegroundColorAttributeName:[CommonTools changeColor:@"0x666666"]} range:NSMakeRange(0, titleString.length)];
    }else{
        attributedString = [[NSMutableAttributedString alloc] initWithString:titleString];
        [attributedString setAttributes:@{NSForegroundColorAttributeName:[CommonTools changeColor:@"0x25ca86"]} range:NSMakeRange(0, titleString.length)];
    }
    if(bridgeString.length>0){
        NSRange range = [titleString rangeOfString:bridgeString];
        [attributedString setAttributes:@{NSForegroundColorAttributeName:[CommonTools changeColor:@"0xff0000"]} range:range];
    }
    return attributedString;
}

- (void)setItemBridge:(NSInteger)count atIndex:(NSInteger)index{
    NSArray *titleArray = @[@"新任务",@"待取货",@"配送中"];
    if(index<0)
        index = 0;
    else if (index>2)
        index = 2;
    NSString *newString;
    if(count>0){
        newString = [NSString stringWithFormat:@"%@(%ld)",titleArray[index],count];
    }else{
        newString = titleArray[index];
    }
    UIButton *item = [self viewWithTag:index + 9990];
    VMTabBarView *nextTabBarView = [self viewWithTag:index+10000];
    NSMutableAttributedString *nextAttributedString = [self setupTabBarItemTitle:newString state:!item.enabled];
    [nextTabBarView.titleLabel setAttributedText:nextAttributedString];
}
@end
