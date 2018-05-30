//
//  ZTInfiniteListView.m
//
//  Created by zuoming on 2018/4/11.
//  Copyright © 2018年 zuoming. All rights reserved.
//

#import "ZTInfiniteListView.h"
#import "ZTInfiniteContainerCell.h"

@interface ZTInfiniteListView ()<UIScrollViewDelegate>

@property (nonatomic, strong) NSMutableArray *containerCellList; /**<  */
@property (nonatomic, assign) ZTInfiniteDefaultSelectPosition defaultSelectPosition;  /**<  */

@property (nonatomic, strong) NSNumber *selectedIndex;  /**<  */

@end

@implementation ZTInfiniteListView

-(void)dealloc
{
    
}

- (instancetype)init
{
    return [self initWithDefaultSelectPosition:ZTInfiniteDefaultSelectPositionRight];
}

- (instancetype)initWithDefaultSelectPosition:(ZTInfiniteDefaultSelectPosition)defaultSelectPosition
{
    self = [super init];
    if (self) {
        self.defaultSelectPosition = defaultSelectPosition;
        self.delegate = self;
        self.containerCellList = [NSMutableArray array];
        self.selectedIndex = nil;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        
        self.alwaysBounceHorizontal = YES; //只横向
        self.alwaysBounceVertical = NO;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if ([self getCellCount] != self.containerCellList.count) {
        [self createContainerViews];
    } else if (self.containerCellList.count == 0) {
        [self createContainerViews];
    }
    
    CGFloat cellWidth = [self widthForItem];
    for (NSInteger i = 0; i < self.containerCellList.count; i++) {
        ZTInfiniteContainerCell *containerCell = self.containerCellList[i];
        containerCell.frame = CGRectMake(i * cellWidth, 0, cellWidth, CGRectGetHeight(self.frame));
    }
    
    [self requestCells];
}

- (NSInteger)getCellCount
{
    CGFloat cellWidth = [self widthForItem];
    NSInteger count = (NSInteger)(CGRectGetWidth(self.frame) / cellWidth) + 2;
    return count;
}

- (void)createContainerViews
{
    [self.containerCellList makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.containerCellList removeAllObjects];
    
    CGFloat cellWidth = [self widthForItem];
    if (cellWidth <= 1) {
        return;
    }
    NSInteger count = [self getCellCount];
    self.contentSize = CGSizeMake(count * cellWidth, CGRectGetHeight(self.frame));
    
    NSInteger firstIndex = 0;
    if (self.defaultSelectPosition == ZTInfiniteDefaultSelectPositionLeft) {
        firstIndex = 0;
        self.contentOffset = CGPointMake(0, 0);
    } else if (self.defaultSelectPosition == ZTInfiniteDefaultSelectPositionCenter) {
        NSNumber *minIndex = [self minIndex];
        if (minIndex && (-minIndex.integerValue * cellWidth + cellWidth / 2 < CGRectGetWidth(self.frame) / 2)) {
            firstIndex = minIndex.integerValue;
            self.contentOffset = CGPointMake(0, 0);
        } else {
            firstIndex = count % 2 == 0 ? -(count/ 2 - 1) : -count / 2;
            CGFloat offset = cellWidth * (count / 2 - 1) + cellWidth / 2 - CGRectGetWidth(self.frame) / 2;
            self.contentOffset = CGPointMake(offset, 0);
        }
    }if (self.defaultSelectPosition == ZTInfiniteDefaultSelectPositionRight) {
        NSNumber *minIndex = [self minIndex];
        if (minIndex && (-minIndex.integerValue * cellWidth < CGRectGetWidth(self.frame))) {
            firstIndex = minIndex.integerValue;
            self.contentOffset = CGPointMake(0, 0);
        } else {
            firstIndex = -(count - 2);
            CGFloat offset = self.contentSize.width - CGRectGetWidth(self.frame);
            self.contentOffset = CGPointMake(offset, 0);
        }
    }
    
    for (NSInteger i = 0; i < count; i++) {
        ZTInfiniteContainerCell *cell = [[ZTInfiniteContainerCell alloc] init];
        cell.infiniteIndex = firstIndex + i;
        __weak typeof(self)weakSelf = self;
        cell.didClickCell = ^(NSInteger idx) {
            [weakSelf clickAtIndex:idx];
        };
        [self addSubview:cell];
        [self.containerCellList addObject:cell];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    UITouch *touch = touches.anyObject;
    ZTInfiniteContainerCell *containerCell = [self containerCellWithLocation:[touch locationInView:self]];
    [containerCell setHighlight:YES];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    UITouch *touch = touches.anyObject;
    ZTInfiniteContainerCell *containerCell = [self containerCellWithLocation:[touch locationInView:self]];
    if (containerCell && [self shouldSelectAtIndex:containerCell.infiniteIndex]) {
        self.selectedIndex = @(containerCell.infiniteIndex);
        [self clickAtIndex:containerCell.infiniteIndex];
    }
    [self refreshHilightState];
}

- (void)updateSelectedIndex:(NSInteger)selectedIndex
{
    self.selectedIndex = @(selectedIndex);
    [self refreshHilightState];
}

- (ZTInfiniteContainerCell *)containerCellWithLocation:(CGPoint)location
{
    ZTInfiniteContainerCell *result = nil;
    for (ZTInfiniteContainerCell *containerCell in self.containerCellList) {
        if (CGRectGetMaxX(containerCell.frame) > location.x
            && CGRectGetMinX(containerCell.frame) < location.x
            && CGRectGetMaxY(containerCell.frame) > location.y
            && CGRectGetMinY(containerCell.frame) < location.y) {
            result = containerCell;
        }
    }
    
    return result;
}

- (void)refreshHilightState
{
    __weak typeof(self)weakSelf = self;
    [self.containerCellList enumerateObjectsUsingBlock:^(ZTInfiniteContainerCell *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj setHighlight:obj.infiniteIndex == weakSelf.selectedIndex.integerValue];
    }];
}

- (void)reloadData
{
    [self createContainerViews];
    [self setNeedsLayout];
}

- (void)requestCells
{
    CGFloat start = self.contentOffset.x;
    CGFloat end = self.contentOffset.x + CGRectGetWidth(self.frame);
    for (ZTInfiniteContainerCell *containerCell in self.containerCellList) {
        if ((CGRectGetMinX(containerCell.frame) > start && CGRectGetMinX(containerCell.frame) < end)
            || (CGRectGetMaxX(containerCell.frame) > start && CGRectGetMaxX(containerCell.frame) < end)) {
            ZTInfiniteCell *cell = [self itemViewForIndex:containerCell.infiniteIndex];
            if (cell) {
                [containerCell addInfiniteCell:cell];
            }
            [containerCell setHighlight:containerCell.infiniteIndex == self.selectedIndex.integerValue];
        }
    }
}

- (void)adjustIndex:(NSInteger)addtion
{
    for (ZTInfiniteContainerCell *containerCell in self.containerCellList) {
        containerCell.infiniteIndex = containerCell.infiniteIndex - addtion;
    }
    [self requestCells];
}

- (NSArray<ZTInfiniteContainerCell *> *)visibleContainerCells
{
    __block NSMutableArray *list = [NSMutableArray array];
    [self.containerCellList enumerateObjectsUsingBlock:^(ZTInfiniteContainerCell *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ((CGRectGetMinX(obj.frame) > self.contentOffset.x
             && CGRectGetMinX(obj.frame) < self.contentOffset.x + CGRectGetWidth(self.frame))
            ||(CGRectGetMaxX(obj.frame) > self.contentOffset.x
               && CGRectGetMaxX(obj.frame) < self.contentOffset.x + CGRectGetWidth(self.frame)))
        {
            [list addObject:obj];
        }
    }];
    
    return list;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSArray<ZTInfiniteContainerCell *> *visibleContainerCells = [self visibleContainerCells];
    
    if ([self.infiniteDelegate respondsToSelector:@selector(maxIndexOfInfiniteListView:)]) {
        NSNumber *maxIndex = [self.infiniteDelegate maxIndexOfInfiniteListView:self];
        if ([(ZTInfiniteContainerCell *)visibleContainerCells.lastObject infiniteIndex] >= maxIndex.integerValue && maxIndex) {
            return;
        }
    }
    if ([self.infiniteDelegate respondsToSelector:@selector(minIndexOfInfiniteListView:)]) {
        NSNumber *minIndex = [self.infiniteDelegate minIndexOfInfiniteListView:self];
        if ([(ZTInfiniteContainerCell *)visibleContainerCells.firstObject infiniteIndex] <= minIndex.integerValue && minIndex) {
            return;
        }
    }
    if (self.contentOffset.x > [self widthForItem]) {
        self.contentOffset = CGPointMake(self.contentOffset.x - [self widthForItem], 0);
        [self adjustIndex:-1];
    } else if (self.contentOffset.x < 0) {
        self.contentOffset = CGPointMake(self.contentOffset.x + [self widthForItem], 0);
        [self adjustIndex:1];
    }
}

- (CGFloat)widthForItem
{
    if ([self.infiniteDelegate respondsToSelector:@selector(widthOfCellInInfiniteListView:)]) {
        return [self.infiniteDelegate widthOfCellInInfiniteListView:self];
    }
    return 0;
}

- (ZTInfiniteCell *)itemViewForIndex:(NSInteger)idx
{
    if ([self.infiniteDelegate respondsToSelector:@selector(infiniteListView:cellAtIndex:)]) {
        return [self.infiniteDelegate infiniteListView:self cellAtIndex:idx];
    }
    return nil;
}

- (void)clickAtIndex:(NSInteger)idx
{
    if ([self.infiniteDelegate respondsToSelector:@selector(infiniteListView:didSelectCellAtIndex:)]) {
        return [self.infiniteDelegate infiniteListView:self didSelectCellAtIndex:idx];
    }
}

- (NSNumber *)minIndex
{
    if ([self.infiniteDelegate respondsToSelector:@selector(minIndexOfInfiniteListView:)]) {
        return [self.infiniteDelegate minIndexOfInfiniteListView:self];
    }
    return nil;
}

- (BOOL)shouldSelectAtIndex:(NSInteger)idx
{
    if ([self.infiniteDelegate respondsToSelector:@selector(infiniteListView:shouldSelectCellAtIndex:)]) {
        return [self.infiniteDelegate infiniteListView:self shouldSelectCellAtIndex:idx];
    }
    return YES;
}

@end
