//
//  NSString+TFTime.h
//  FlyMusic
//
//  Created by 谢腾飞 on 16/8/23.
//  Copyright © 2016年 谢腾飞. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@interface NSString (TFTime)
/**
 *  播放器_时间转换
 */
+ (NSString *)convertTime:(CGFloat)second;

+ (NSString *)dateToString:(NSDate*)date;

@end
