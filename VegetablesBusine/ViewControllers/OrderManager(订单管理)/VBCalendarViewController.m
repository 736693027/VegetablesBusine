//
//  VBCalendarViewController.m
//  VegetablesBusine
//
//  Created by 刘少轩 on 2018/6/9.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "VBCalendarViewController.h"
#import "JTCalendar.h"
#import "UIView+YYAdd.h"
#import <ReactiveObjC/ReactiveObjC.h>

@interface VBCalendarViewController ()<JTCalendarDataSource>{
    JTCalendarMenuView *calendarMenuView;//日历的状态栏
    JTCalendarContentView *calendarContentView;//日历的内容
    JTCalendar *mainCalendar;//日历
}

@end

@implementation VBCalendarViewController

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    //文档说明，必须写在这个方法里面
    [mainCalendar reloadData];
}

- (void)navLeftButtonClicked:(UIButton *)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"选择日期";
    
    self.view.backgroundColor = [CommonTools changeColor:@"0xefefef"];
    //日历
    mainCalendar = [[JTCalendar alloc] init];
    mainCalendar.calendarAppearance.calendar.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 50)];
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = backView.bounds;
    gradient.colors = [NSArray arrayWithObjects:
                       (id)[CommonTools changeColor:@"0x00d794"].CGColor,
                       (id)[CommonTools changeColor:@"0x67c7c7"].CGColor, nil];
    gradient.startPoint = CGPointMake(0, 0);
    gradient.endPoint = CGPointMake(1, 1);
    [backView.layer addSublayer:gradient];
    [self.view addSubview:backView];
    
    //日历标题
    calendarMenuView = [[JTCalendarMenuView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 50)];
    [self.view addSubview:calendarMenuView];
    
    //日历内容
    calendarContentView = [[JTCalendarContentView alloc] initWithFrame:CGRectMake(0, calendarMenuView.bottom, SCREEN_WIDTH, 300)];
    calendarContentView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:calendarContentView];
    
    //设置基本属性和数据源
    mainCalendar.calendarAppearance.calendar.firstWeekday = 2; // Sunday == 1, Saturday == 7
    mainCalendar.calendarAppearance.dayCircleRatio = 9. / 10.;
    mainCalendar.calendarAppearance.ratioContentMenu = 1.;
    mainCalendar.calendarAppearance.menuMonthTextColor = [UIColor whiteColor];//标题字体颜色
    mainCalendar.calendarAppearance.dayCircleColorSelected = [CommonTools changeColor:@"0x25ca86"];//选中日期北京色
    mainCalendar.calendarAppearance.dayTextColorSelected = [UIColor whiteColor];//选中日期字体颜色
    mainCalendar.calendarAppearance.weekDayTextFont = [UIFont systemFontOfSize:17];
    mainCalendar.calendarAppearance.weekDayTextColor = [CommonTools changeColor:@"0x00b2b2"];
    mainCalendar.calendarAppearance.weekDayFormat = JTCalendarWeekDayFormatSingle;
    mainCalendar.calendarAppearance.isWeekMode = NO;
    [mainCalendar setMenuMonthsView:calendarMenuView];
    [mainCalendar setContentView:calendarContentView];
    [mainCalendar setDataSource:self];
}
#pragma mark JTCalendar dataSource
- (BOOL)calendarHaveEvent:(JTCalendar *)calendar date:(NSDate *)date
{
    //返回YES，则在date所显示的那天进行标记
    return NO;
}
#pragma mark JTCanlendar 点击事件
- (void)calendarDidDateSelected:(JTCalendar *)calendar date:(NSDate *)date
{
    if(self.dateSubject){
        [self.dateSubject sendNext:date];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
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
