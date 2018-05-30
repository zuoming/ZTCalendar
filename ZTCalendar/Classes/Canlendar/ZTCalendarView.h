//
//  ZTCalendarView.h
//
//  Created by zuoming on 2018/4/12.
//  Copyright © 2018年 zuoming. All rights reserved.
//

#import "ZTInfiniteListView.h"

@class ZTCalendarView;

@protocol ZTCalendarViewDelegate <NSObject>

@required
- (CGFloat)widthOfCellInCalendarView:(ZTCalendarView *)calendarView;
- (ZTInfiniteCell *)calendarView:(ZTCalendarView *)calendarView cellAtDate:(NSDate *)date;

@optional
/** 是否可以高亮显示 */
- (BOOL)shouldHilightDateShowing:(ZTCalendarView *)calendarView;
/** 默认选中显示的日期 */
- (NSDate *)dateShowingOfCalendarView:(ZTCalendarView *)calendarView;
/** 是否可以被选中 */
- (BOOL)calendarView:(ZTCalendarView *)calendarView shouldSelectCellAtDate:(NSDate *)date;
- (void)calendarView:(ZTCalendarView *)calendarView didSelectCellAtDate:(NSDate *)date;
- (NSDate *)maxDateOfCalendarView:(ZTCalendarView *)calendarView;
- (NSDate *)minDateOfCalendarView:(ZTCalendarView *)calendarView;

@end

@interface ZTCalendarView : ZTInfiniteListView

@property (nonatomic, assign) id<ZTCalendarViewDelegate> calendarDelegate;  /**<  */

@end
