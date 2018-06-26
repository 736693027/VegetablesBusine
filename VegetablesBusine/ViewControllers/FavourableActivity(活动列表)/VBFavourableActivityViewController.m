//
//  VBFavourableActivityViewController.m
//  VegetablesBusine
//
//  Created by Apple on 2018/6/25.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "VBFavourableActivityViewController.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import <Masonry/Masonry.h>
#import "VBTitleView.h"

@interface VBFavourableActivityViewController ()

@end

@implementation VBFavourableActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
       
    VBTitleView *titleView = [[VBTitleView alloc] initWithFrame:CGRectMake(0, 0, 200, 45)];
    titleView.selectIndexSubject = [RACSubject subject];
    [titleView.selectIndexSubject subscribeNext:^(NSNumber  *_Nullable index) {
        
    }];
    self.navigationItem.titleView = titleView;
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
