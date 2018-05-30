//
//  ZTCalendarView.m
//
//  Created by zuoming on 2018/4/12.
//  Copyright © 2018年 zuoming. All rights reserved.
//

#import "ZTCalendarView.h"
#import "NSDate+ZTCalendar.h"

@interface ZTCalendarView ()<ZTInfiniteListViewDelegate>

@end

@implementation ZTCalendarView

- (instancetype)initWithDefaultSelectPosition:(ZTInfiniteDefaultSelectPosition)defaultSelectPosition
{
    self = [super initWithDefaultSelectPosition:defaultSelectPosition];
    if (self) {
        self.infiniteDelegate = self;
    }
    return self;
}

- (void)setCalendarDelegate:(id<ZTCalendarViewDelegate>)calendarDelegate
{
    _calendarDelegate = calendarDelegate;
    if ([self shouldHilightDateShowing]) {
        [self updateSelectedIndex:0];
    }
}

#pragma mark - ZTInfiniteListViewDelegate

- (CGFloat)widthOfCellInInfiniteListView:(ZTInfiniteListView *)infiniteListView;
{
    if ([self.calendarDelegate respondsToSelector:@selector(widthOfCellInCalendarView:)]) {
        return [self.calendarDelegate widthOfCellInCalendarView:self];
    }
    return 0;
}

- (ZTInfiniteCell *)infiniteListView:(ZTInfiniteListView *)infiniteListView cellAtIndex:(NSInteger)idx
{
    if ([self.calendarDelegate respondsToSelector:@selector(calendarView:cellAtDate:)]) {
        return [self.calendarDelegate calendarView:self cellAtDate:[self dateAtIndex:idx]];
    }
    return nil;
}

- (BOOL)infiniteListView:(ZTInfiniteListView *)infiniteListView shouldSelectCellAtIndex:(NSInteger)idx
{
    if ([self.calendarDelegate respondsToSelector:@selector(calendarView:shouldSelectCellAtDate:)]) {
        return [self.calendarDelegate calendarView:self shouldSelectCellAtDate:[self dateAtIndex:idx]];
    }
    return YES;
}

- (void)infiniteListView:(ZTInfiniteListView *)infiniteListView didSelectCellAtIndex:(NSInteger)idx
{
    if ([self.calendarDelegate respondsToSelector:@selector(calendarView:didSelectCellAtDate:)]) {
        return [self.calendarDelegate calendarView:self didSelectCellAtDate:[self dateAtIndex:idx]];
    }
}

- (NSNumber *)maxIndexOfInfiniteListView:(ZTInfiniteListView *)infiniteListView
{
    if ([self.calendarDelegate respondsToSelector:@selector(maxDateOfCalendarView:)]) {
        NSDate *maxDate = [self.calendarDelegate maxDateOfCalendarView:self];
        NSDate *selectedDate = [self dateShowing];
        NSInteger idx = [maxDate ztc_daysSince:selectedDate];
        return @(idx);
    }
    return nil;
}

- (NSNumber *)minIndexOfInfiniteListView:(ZTInfiniteListView *)infiniteListView
{
    if ([self.calendarDelegate respondsToSelector:@selector(minDateOfCalendarView:)]) {
        NSDate *minDate = [self.calendarDelegate minDateOfCalendarView:self];
        NSDate *selectedDate = [self dateShowing];
        NSInteger idx = [minDate ztc_daysSince:selectedDate];
        return @(idx);
    }
    return nil;
}

#pragma mark -

- (BOOL)shouldHilightDateShowing
{
    if ([self.calendarDelegate respondsToSelector:@selector(shouldHilightDateShowing:)]) {
        return [self.calendarDelegate shouldHilightDateShowing:self];
    }
    return NO;
}

- (NSDate *)dateShowing
{
    if ([self.calendarDelegate respondsToSelector:@selector(dateShowingOfCalendarView:)]) {
        return [self.calendarDelegate dateShowingOfCalendarView:self];
    }
    return [NSDate date];
}

- (NSDate *)dateAtIndex:(NSInteger)idx
{
    NSDate *selectedDate = [self dateShowing];
    NSDate *date = [selectedDate ztc_dateBefore:-idx];
    
    return date;
}

@end
