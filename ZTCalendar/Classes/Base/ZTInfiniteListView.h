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
- (CGFloat)widthOfCellInInfiniteListView:(ZTInfiniteListView *)infiniteListView;
- (ZTInfiniteCell *)infiniteListView:(ZTInfiniteListView *)infiniteListView cellAtIndex:(NSInteger)idx;

@optional
- (BOOL)infiniteListView:(ZTInfiniteListView *)infiniteListView shouldSelectCellAtIndex:(NSInteger)idx;
- (void)infiniteListView:(ZTInfiniteListView *)infiniteListView didSelectCellAtIndex:(NSInteger)idx;
- (NSNumber *)maxIndexOfInfiniteListView:(ZTInfiniteListView *)infiniteListView;
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
