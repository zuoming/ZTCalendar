//
//  NSDate+ZTCalendar.h
//
//  Created by zuoming on 2018/4/12.
//  Copyright © 2018年 zuoming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (ZTCalendar)

- (NSInteger)ztc_daysSince:(NSDate *)date;

- (NSDate *)ztc_dateBefore:(NSInteger)days;

@end
