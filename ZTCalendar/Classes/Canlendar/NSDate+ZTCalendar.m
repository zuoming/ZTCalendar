//
//  NSDate+ZTCalendar.m
//
//  Created by zuoming on 2018/4/12.
//  Copyright © 2018年 zuoming. All rights reserved.
//

#import "NSDate+ZTCalendar.h"

@implementation NSDate (ZTCalendar)

- (NSDate *)ztc_dateBefore:(NSInteger)days
{
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:( NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond ) fromDate:self];
    
    [components setHour:-24 * days];
    [components setMinute:0];
    [components setSecond:0];
    NSDate *before = [cal dateByAddingComponents:components toDate:self options:0];
    
    return before;
}

- (NSInteger)ztc_daysSince:(NSDate *)date
{
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [gregorian setFirstWeekday:2];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *fromDate;
    NSDate *toDate;
    [gregorian rangeOfUnit:NSCalendarUnitDay startDate:&fromDate interval:NULL forDate:date];
    [gregorian rangeOfUnit:NSCalendarUnitDay startDate:&toDate interval:NULL forDate:self];
    NSDateComponents *components = [gregorian components:NSCalendarUnitDay fromDate:fromDate toDate:toDate options:0];
    return components.day;
}

@end
