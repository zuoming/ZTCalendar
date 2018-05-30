//
//  ZTInfinitePlaceholderCell.h
//
//  Created by zuoming on 2018/4/11.
//  Copyright © 2018年 zuoming. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZTInfiniteCell;

@interface ZTInfiniteContainerCell : UIView

@property (nonatomic, strong) void (^didClickCell)(NSInteger idx); /**<  */

@property (nonatomic, assign) NSInteger infiniteIndex;  /**<  */

- (void)addInfiniteCell:(ZTInfiniteCell *)infiniteCell;
- (void)removeInfiniteCell;
- (void)setHighlight:(BOOL)hightlight;

@end
