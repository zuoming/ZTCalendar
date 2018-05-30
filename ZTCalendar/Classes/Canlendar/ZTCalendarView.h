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
/** 单元格宽度 */
- (CGFloat)widthOfCellInCalendarView:(ZTCalendarView *)calendarView;
/** 创建日期单元格 */
- (ZTInfiniteCell *)calendarView:(ZTCalendarView *)calendarView cellAtDate:(NSDate *)date;

@optional
/** 是否可以高亮显示 */
- (BOOL)shouldHilightDateShowing:(ZTCalendarView *)calendarView;
/** 默认选中显示的日期 */
- (NSDate *)dateShowingOfCalendarView:(ZTCalendarView *)calendarView;
/** 是否可以被选中 */
- (BOOL)calendarView:(ZTCalendarView *)calendarView shouldSelectCellAtDate:(NSDate *)date;
/** 选中日期 */
- (void)calendarView:(ZTCalendarView *)calendarView didSelectCellAtDate:(NSDate *)date;
/** 最大结束时间 */
- (NSDate *)maxDateOfCalendarView:(ZTCalendarView *)calendarView;
/** 最小开始时间 */
- (NSDate *)minDateOfCalendarView:(ZTCalendarView *)calendarView;

@end

@interface ZTCalendarView : ZTInfiniteListView

@property (nonatomic, assign) id<ZTCalendarViewDelegate> calendarDelegate;  /**<  */

@end
