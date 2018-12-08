//
//  VBMapViewController.m
//  VegetablesBusine
//
//  Created by Apple on 2018/12/8.
//  Copyright © 2018 Apple. All rights reserved.
//

#import "VBMapViewController.h"
#import <MAMapKit/MAMapKit.h>

@interface VBMapViewController ()<MAMapViewDelegate>

@property (strong, nonatomic) MAMapView *mapView;

@end

@implementation VBMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"位置";
    
    self.mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    self.mapView.delegate = self;
    [self.view addSubview:self.mapView];
    
//    MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
//    pointAnnotation.coordinate = CLLocationCoordinate2DMake(self.Longitude.floatValue, self.latitude.floatValue);
//    pointAnnotation.title = @"";
//    pointAnnotation.subtitle = @"";
//    [_mapView addAnnotation:pointAnnotation];
    MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
    pointAnnotation.coordinate = CLLocationCoordinate2DMake(39.989631, 116.481018);
    pointAnnotation.title = @"方恒国际";
    pointAnnotation.subtitle = @"阜通东大街6号";
    [_mapView addAnnotation:pointAnnotation];
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
