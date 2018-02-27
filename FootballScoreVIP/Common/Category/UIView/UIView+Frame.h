//
//  UIView+Frame.h
//  MVP
//
//  Created by 田伟 on 2018/1/9.
//  Copyright © 2018年 SHGXQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)
// 加前缀避免冲突
@property CGFloat tw_width;
@property CGFloat tw_height;
@property CGFloat tw_x;
@property CGFloat tw_y;

@property CGFloat tw_centerX;
@property CGFloat tw_centerY;
@end
