//
//  ZTInfinitePlaceholderCell.m
//
//  Created by zuoming on 2018/4/11.
//  Copyright © 2018年 zuoming. All rights reserved.
//

#import "ZTInfiniteContainerCell.h"
#import "ZTInfiniteCell.h"

@interface ZTInfiniteContainerCell ()

@property (nonatomic, strong) UIButton *selectButton; /**<  */
@property (nonatomic, strong) ZTInfiniteCell *infiniteCell; /**<  */

@end

@implementation ZTInfiniteContainerCell

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self configureView];
    }
    
    return self;
}

- (void)configureView
{
    [self addSubview:self.selectButton];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.selectButton.frame = self.bounds;
    self.infiniteCell.frame = self.bounds;
}

- (void)setHighlight:(BOOL)hightlight
{
    [self.infiniteCell setHighlight:hightlight];
}

- (void)addInfiniteCell:(ZTInfiniteCell *)infiniteCell
{
    [self.infiniteCell removeFromSuperview];
    [infiniteCell removeFromSuperview];
    [self addSubview:infiniteCell];
    self.infiniteCell = infiniteCell;
}

- (void)removeInfiniteCell
{
    [self.infiniteCell removeFromSuperview];
    self.infiniteCell = nil;
}

- (void)clickSelectButton
{
    if (self.didClickCell) {
        self.didClickCell(self.infiniteIndex);
    }
}

/**  */
- (UIButton *)selectButton
{
    if (_selectButton) {
        return _selectButton;
    }
    
    UIButton *button = [[UIButton alloc] init];
    button.backgroundColor = [UIColor clearColor];
    [button addTarget:self action:@selector(clickSelectButton) forControlEvents:UIControlEventTouchUpInside];

    _selectButton = button;
    return _selectButton;
}
@end
