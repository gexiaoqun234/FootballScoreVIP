//
//  UIImage+Image.h
//  BuDeJie
//
//  Created by 田伟 on 2017/1/18.
//  Copyright © 2017年 公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Image)

/** 快速创建一个平铺的图片*/
+ (instancetype)imageTileWithName:(NSString *)imageName;

/** 快速创建一个不渲染的图片 */
+ (instancetype)imageOriginalWithName:(NSString *)imageName;

/** 将图片变成圆形 */
- (instancetype)tw_circleImage;
+ (instancetype)tw_circleImageNamed:(NSString *)imageName;

@end
