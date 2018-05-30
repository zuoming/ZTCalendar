//
//  ZTIndexCell.m
//  ZTCalendar_Example
//
//  Created by zuoming on 2018/5/30.
//  Copyright © 2018年 baggio.zuoming@gmail.com. All rights reserved.
//

#import "ZTIndexCell.h"

@implementation ZTIndexCell

- (void)dealloc
{
    
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor yellowColor];
        [self addSubview:self.label];
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        self.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.label.frame = self.bounds;
}

/**  */
- (UILabel *)label
{
    if (_label) {
        return _label;
    }
    
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:15.0f];
    label.textColor = [UIColor blackColor];
    label.numberOfLines = 0;
    
    _label = label;
    return _label;
}

- (void)setHighlight:(BOOL)hightlight
{
    if (hightlight) {
        self.backgroundColor = [UIColor redColor];
    } else {
        self.backgroundColor = [UIColor yellowColor];
    }
}
@end
