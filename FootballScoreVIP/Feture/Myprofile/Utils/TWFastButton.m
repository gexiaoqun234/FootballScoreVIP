//
//  TWFastButton.m
//  BuDeJie
//
//  Created by 田伟 on 2017/1/31.
//  Copyright © 2017年 公司. All rights reserved.
//

#import "TWFastButton.h"

@implementation TWFastButton

- (void)layoutSubviews{
    [super layoutSubviews];
    self.imageView.tw_y = 0;
    self.imageView.tw_centerX = self.tw_width * 0.5;
    self.titleLabel.tw_y = self.tw_height - self.titleLabel.tw_height;
    [self.titleLabel sizeToFit];
    self.titleLabel.tw_centerX = self.tw_width * 0.5;
}

@end
