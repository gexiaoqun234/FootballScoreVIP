//
//  TWMultipleButton.m
//  105CP
//
//  Created by 田伟 on 2017/11/3.
//  Copyright © 2017年 宋辉. All rights reserved.
//

#import "TWMultipleButton.h"

@implementation TWMultipleButton

- (instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        self.titleLabel.font = [UIFont systemFontOfSize:16];
        // 一开始就将不同状态下的文字颜色设置全
        [self setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    }
    return self;
}

- (void)setSelected:(BOOL)selected{
    self.layer.borderColor = [UIColor redColor].CGColor;
    self.layer.borderWidth = 1;
    [super setSelected:selected];
}

- (void)setHighlighted:(BOOL)highlighted{

}

@end
