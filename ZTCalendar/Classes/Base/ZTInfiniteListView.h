//
//  ZTInfiniteListView.h
//
//  Created by zuoming on 2018/4/11.
//  Copyright © 2018年 zuoming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZTInfiniteCell.h"

@class ZTInfiniteListView;

@protocol ZTInfiniteListViewDelegate <NSObject>

@required
/** 单元格宽度 */
- (CGFloat)widthOfCellInInfiniteListView:(ZTInfiniteListView *)infiniteListView;
/** 创建单元格 */
- (ZTInfiniteCell *)infiniteListView:(ZTInfiniteListView *)infiniteListView cellAtIndex:(NSInteger)idx;

@optional
/** 是否可以被选中 */
- (BOOL)infiniteListView:(ZTInfiniteListView *)infiniteListView shouldSelectCellAtIndex:(NSInteger)idx;
/** 选中 */
- (void)infiniteListView:(ZTInfiniteListView *)infiniteListView didSelectCellAtIndex:(NSInteger)idx;
/** 最大结束序号 */
- (NSNumber *)maxIndexOfInfiniteListView:(ZTInfiniteListView *)infiniteListView;
/** 最小开始序号 */
- (NSNumber *)minIndexOfInfiniteListView:(ZTInfiniteListView *)infiniteListView;

@end

typedef NS_ENUM(NSUInteger, ZTInfiniteDefaultSelectPosition) {
    ZTInfiniteDefaultSelectPositionLeft = 0,
    ZTInfiniteDefaultSelectPositionCenter,
    ZTInfiniteDefaultSelectPositionRight
};

@interface ZTInfiniteListView : UIScrollView

@property (nonatomic, assign) id<ZTInfiniteListViewDelegate> infiniteDelegate;  /**<  */

- (instancetype)initWithDefaultSelectPosition:(ZTInfiniteDefaultSelectPosition)defaultSelectPosition;

- (void)updateSelectedIndex:(NSInteger)selectedIndex;

- (void)reloadData;

@end
