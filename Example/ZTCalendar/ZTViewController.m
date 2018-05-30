//
//  ZTViewController.m
//  ZTCalendar
//
//  Created by baggio.zuoming@gmail.com on 05/30/2018.
//  Copyright (c) 2018 baggio.zuoming@gmail.com. All rights reserved.
//

#import "ZTViewController.h"
#import "ZTCalendarView.h"
#import "ZTCalendarCell.h"
#import "ZTInfiniteListView.h"
#import "ZTIndexCell.h"

@interface ZTViewController ()<ZTCalendarViewDelegate, ZTInfiniteListViewDelegate>

@property (nonatomic, strong) ZTCalendarView *calendarView; /**<  */
@property (nonatomic, strong) UILabel *calendarLabel; /**<  */

@property (nonatomic, strong) ZTInfiniteListView *infiniteListView; /**<  */
@property (nonatomic, strong) UILabel *infiniteLabel; /**<  */

@end

@implementation ZTViewController

- (void)dealloc
{
    _calendarView.calendarDelegate = nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.calendarView];
    [self.view addSubview:self.calendarLabel];
    [self.view addSubview:self.infiniteListView];
    [self.view addSubview:self.infiniteLabel];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.calendarView.frame = CGRectMake(0, 100, CGRectGetWidth(self.view.frame), 80);
    self.calendarLabel.frame = CGRectMake(0, 185, CGRectGetWidth(self.view.frame), 20);
    self.infiniteListView.frame = CGRectMake(0, 240, CGRectGetWidth(self.view.frame), 80);
    self.infiniteLabel.frame = CGRectMake(0, 325, CGRectGetWidth(self.view.frame), 20);
}

#pragma mark - ZTCalendarViewDelegate

- (CGFloat)widthOfCellInCalendarView:(ZTCalendarView *)calendarView
{
    return 70;
}

- (ZTInfiniteCell *)calendarView:(ZTCalendarView *)calendarView cellAtDate:(NSDate *)date
{
    ZTCalendarCell *cell = [[ZTCalendarCell alloc] init];
    [cell configureWith:date];
    
    return cell;
}

- (BOOL)shouldHilightDateShowing:(ZTCalendarView *)calendarView
{
    return YES;
}

- (NSDate  * _Nonnull )dateShowingOfCalendarView:(ZTCalendarView *)calendarView
{
    return [NSDate date];
}

- (BOOL)calendarView:(ZTCalendarView *)calendarView shouldSelectCellAtDate:(NSDate *)date
{
    return YES;
    //    return [date ztc_daysSince:self.helper.babyInfo.birthdayDate] < 10;
}

- (void)calendarView:(ZTCalendarView *)calendarView didSelectCellAtDate:(NSDate *)date
{
    NSLog(@"%@", date);
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    self.calendarLabel.text = [NSString stringWithFormat:@"选中日期：%@", [dateFormatter stringFromDate:date]];
}

- (NSDate *)minDateOfCalendarView:(ZTCalendarView *)calendarView
{
    return [NSDate dateWithTimeIntervalSinceNow:-10*24*60*60];
}

#pragma mark - ZTInfiniteListViewDelegate

- (CGFloat)widthOfCellInInfiniteListView:(ZTInfiniteListView *)infiniteListView
{
    return 70.0f;
}

- (ZTInfiniteCell *)infiniteListView:(ZTInfiniteListView *)infiniteListView cellAtIndex:(NSInteger)idx
{
    ZTIndexCell *cell = [[ZTIndexCell alloc] init];
    cell.label.text = [NSString stringWithFormat:@"%zd", idx];
    
    return cell;
}

- (void)infiniteListView:(ZTInfiniteListView *)infiniteListView didSelectCellAtIndex:(NSInteger)idx
{
    self.infiniteLabel.text = [NSString stringWithFormat:@"选中序号：%zd", idx];
}

- (NSNumber *)maxIndexOfInfiniteListView:(ZTInfiniteListView *)infiniteListView
{
    return @10;
}

#pragma mark - 初始化

/**  */
- (ZTCalendarView *)calendarView
{
    if (_calendarView) {
        return _calendarView;
    }
    
    _calendarView = [[ZTCalendarView alloc] initWithDefaultSelectPosition:ZTInfiniteDefaultSelectPositionRight];
    _calendarView.calendarDelegate = self;
    _calendarView.backgroundColor = [UIColor whiteColor];
    
    return _calendarView;
}

/**  */
- (ZTInfiniteListView *)infiniteListView
{
    if (_infiniteListView) {
        return _infiniteListView;
    }
    
    _infiniteListView = [[ZTInfiniteListView alloc] init];
    _infiniteListView.infiniteDelegate = self;
    
    return _infiniteListView;
}

/**  */
- (UILabel *)calendarLabel
{
    if (_calendarLabel) {
        return _calendarLabel;
    }
    
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:20.0f];
    label.textColor = [UIColor darkGrayColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = [NSString stringWithFormat:@"选中日期："];
    
    _calendarLabel = label;
    return _calendarLabel;
}

/**  */
- (UILabel *)infiniteLabel
{
    if (_infiniteLabel) {
        return _infiniteLabel;
    }
    
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:20.0f];
    label.textColor = [UIColor darkGrayColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = [NSString stringWithFormat:@"选中序号："];
    
    _infiniteLabel = label;
    return _infiniteLabel;
}

@end
