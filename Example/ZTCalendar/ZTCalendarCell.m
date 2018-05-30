//
//  ZTCalendarCell.m
//  ZTCalendar_Example
//
//  Created by zuoming on 2018/5/30.
//  Copyright © 2018年 baggio.zuoming@gmail.com. All rights reserved.
//

#import "ZTCalendarCell.h"
#import "Masonry.h"


@interface ZTCalendarCell ()

@property (nonatomic, strong) NSDate *date; /**<  */

@property (nonatomic, strong) UIImageView *backgroundView; /**<  */
@property (nonatomic, strong) UILabel *yearLabel; /**<  */
@property (nonatomic, strong) UILabel *dayLabel; /**<  */
@property (nonatomic, strong) UIImageView *lockImageView; /**<  */

@end


@implementation ZTCalendarCell

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self configureView];
    }
    return self;
}

- (void)configureView
{
    [self addSubview:self.backgroundView];
    [self.backgroundView addSubview:self.yearLabel];
    [self.backgroundView addSubview:self.dayLabel];
    [self.backgroundView addSubview:self.lockImageView];
    [self configureConstraints];
}

- (void)configureConstraints
{
    [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(5);
        make.left.equalTo(self).offset(0);
        make.bottom.equalTo(self).offset(-5);
        make.right.equalTo(self).offset(-0);
    }];
    [self.yearLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backgroundView).offset(5);
        make.left.width.equalTo(self.backgroundView);
        make.height.equalTo(@22);
    }];
    [self.dayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.backgroundView).offset(5);
        make.left.width.equalTo(self.backgroundView);
        make.height.equalTo(@25);
    }];
    [self.lockImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@12);
        make.height.equalTo(@16);
        make.right.equalTo(self.backgroundView).offset(-8);
        make.bottom.equalTo(self.backgroundView).offset(-8);
    }];
}

- (void)setHighlight:(BOOL)hightlight
{
    if (hightlight) {
        self.backgroundView.image = [UIImage imageNamed:@"calendar_back_hilight"];
        self.dayLabel.textColor = [UIColor lightGrayColor];
    } else {
        self.backgroundView.image = [UIImage imageNamed:@"calendar_back_normal"];
        self.dayLabel.textColor = [UIColor lightGrayColor];
    }
    if ([self isToday]) {
        self.dayLabel.font = [UIFont boldSystemFontOfSize:16];
    } else {
        self.dayLabel.font = [UIFont boldSystemFontOfSize:20];
    }
}

- (void)configureWith:(NSDate *)date
{
    self.date = date;
    self.dayLabel.text = [self dayText];
    self.yearLabel.text = [self yearText];
}

- (BOOL)isToday
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    return [[dateFormatter stringFromDate:self.date] isEqualToString:[dateFormatter stringFromDate:[NSDate date]]];
}

- (NSString *)dayText
{
    if ([self isToday]) {
        return @"今天";
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd"];
    return [dateFormatter stringFromDate:self.date];
}

- (NSString *)yearText
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //    [dateFormatter setDateFormat:@"yyyy"];
    //    NSString *year = [dateFormatter stringFromDate:self.date];
    [dateFormatter setDateFormat:@"MM"];
    NSString *month = [dateFormatter stringFromDate:self.date];
    NSString *monthCN = @"";
    if ([month isEqualToString:@"01"]) {
        monthCN = @"一月";
    } else if ([month isEqualToString:@"02"]) {
        monthCN = @"二月";
    } else if ([month isEqualToString:@"03"]) {
        monthCN = @"三月";
    } else if ([month isEqualToString:@"04"]) {
        monthCN = @"四月";
    } else if ([month isEqualToString:@"05"]) {
        monthCN = @"五月";
    } else if ([month isEqualToString:@"06"]) {
        monthCN = @"六月";
    } else if ([month isEqualToString:@"07"]) {
        monthCN = @"七月";
    } else if ([month isEqualToString:@"08"]) {
        monthCN = @"八月";
    } else if ([month isEqualToString:@"09"]) {
        monthCN = @"九月";
    } else if ([month isEqualToString:@"10"]) {
        monthCN = @"十月";
    } else if ([month isEqualToString:@"11"]) {
        monthCN = @"十一月";
    } else if ([month isEqualToString:@"12"]) {
        monthCN = @"十二月";
    }
    return [NSString stringWithFormat:@"%@", monthCN];
}

#pragma mark - 初始化

/**  */
- (UIImageView *)backgroundView
{
    if (_backgroundView) {
        return _backgroundView;
    }
    
    _backgroundView = [[UIImageView alloc] init];
    //    _backgroundView.image = [UIImage imageNamed:@"bl_calendar_back_normal"];
    //    _backgroundView.backgroundColor = [UIColor redColor];
    
    return _backgroundView;
}

/**  */
- (UIImageView *)lockImageView
{
    if (_lockImageView) {
        return _lockImageView;
    }
    
    _lockImageView = [[UIImageView alloc] init];
    _lockImageView.image = [UIImage imageNamed:@"bl_calendar_lock"];
    return _lockImageView;
}

/**  */
- (UILabel *)yearLabel
{
    if (_yearLabel) {
        return _yearLabel;
    }
    
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:10.0f];
    label.textColor = [UIColor lightGrayColor];
    label.textAlignment = NSTextAlignmentCenter;
    
    _yearLabel = label;
    return _yearLabel;
}

/**  */
- (UILabel *)dayLabel
{
    if (_dayLabel) {
        return _dayLabel;
    }
    
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:20.0f];
    label.textColor = [UIColor darkGrayColor];
    label.textAlignment = NSTextAlignmentCenter;
    
    _dayLabel = label;
    return _dayLabel;
}

@end
