# ZTCalendar

[![CI Status](https://img.shields.io/travis/baggio.zuoming@gmail.com/ZTCalendar.svg?style=flat)](https://travis-ci.org/baggio.zuoming@gmail.com/ZTCalendar)
[![Version](https://img.shields.io/cocoapods/v/ZTCalendar.svg?style=flat)](https://cocoapods.org/pods/ZTCalendar)
[![License](https://img.shields.io/cocoapods/l/ZTCalendar.svg?style=flat)](https://cocoapods.org/pods/ZTCalendar)
[![Platform](https://img.shields.io/cocoapods/p/ZTCalendar.svg?style=flat)](https://cocoapods.org/pods/ZTCalendar)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

<img src="https://github.com/zuoming/ZTCalendar/blob/master/screenshot.png" width="30%" height="30%">

## Requirements

## Installation

ZTCalendar is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'ZTCalendar'
```

## 创建横向日历

```objc
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

```

### 实现代理方法

```objc
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
}

- (void)calendarView:(ZTCalendarView *)calendarView didSelectCellAtDate:(NSDate *)date
{
    
}

- (NSDate *)minDateOfCalendarView:(ZTCalendarView *)calendarView
{
    return [NSDate dateWithTimeIntervalSinceNow:-10*24*60*60];
}
```

## 创建横向无限滚动视图

```objc
- (ZTInfiniteListView *)infiniteListView
{
    if (_infiniteListView) {
        return _infiniteListView;
    }
    
    _infiniteListView = [[ZTInfiniteListView alloc] init];
    _infiniteListView.infiniteDelegate = self;
    
    return _infiniteListView;
}
```

### 实现代理方法

```objc
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
```

## Author

baggio.zuoming@gmail.com

## License

ZTCalendar is available under the MIT license. See the LICENSE file for more info.
