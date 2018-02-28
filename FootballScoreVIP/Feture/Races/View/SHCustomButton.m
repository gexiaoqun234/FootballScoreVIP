//
//  SHCustomButton.m
//  105CP
//
//  Created by 田伟 on 2017/11/1.
//  Copyright © 2017年 宋辉. All rights reserved.
//

#import "SHCustomButton.h"

@implementation SHCustomButton

- (void)layoutSubviews{
    [super layoutSubviews];
    
    /**
     将按钮上图片置于上方，文字置于下方。系统自动计算好了图片和文字的大小，只需要将其的位置进行调整即可
     图片调整为：上方顶格 居按钮中间(中心点的x等于宽度的一般)
     文字调整为：下方贴底(y值等于整个按钮的高度➖他自己的高度) 居按钮中间
     */
    
    // 设置图片的位置
    self.imageView.tw_y = 0;
    self.imageView.tw_centerX = self.tw_width * 0.5;
    
    // 设置标题的位置
    self.titleLabel.tw_y = self.tw_height - self.titleLabel.tw_height;
    /**
     bug:点击按钮，文字右移
     TWLog(@"%f",self.titleLabel.tw_centerX);打印结果表示，中心点位置在sizeToFit再次计算后被改变了，所以必须先计算再修改，将sizeToFit移动设置self.titleLabel.tw_centerX的前面
     */
    // 重新计算文字的宽度，重新再给label赋值
    [self.titleLabel sizeToFit];
    self.titleLabel.tw_centerX = self.tw_width * 0.5;
}

@end
