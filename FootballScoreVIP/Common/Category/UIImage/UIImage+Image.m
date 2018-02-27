//
//  UIImage+Image.m
//  BuDeJie
//
//  Created by 田伟 on 2017/1/18.
//  Copyright © 2017年 公司. All rights reserved.
//

#import "UIImage+Image.h"

@implementation UIImage (Image)

// 填充背景图片
+ (instancetype)imageTileWithName:(NSString *)imageName{
    UIImage * image = [UIImage imageNamed:imageName];
    CGFloat top = image.size.height * 0.5;
    CGFloat bottom = image.size.height * 0.5;
    CGFloat left = image.size.width * 0.5;
    CGFloat right = image.size.width * 0.5;
    UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
    // 指定为平铺模式
    image = [image resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeTile];
    return image;
}

+ (instancetype)imageOriginalWithName:(NSString *)imageName{
    UIImage * image = [UIImage imageNamed:imageName];
    // 不需要渲染
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return image;
}


/** 将图片变成圆形 */
- (instancetype)tw_circleImage{
    
    // 开启上下文,size填图片的大小，opaque填NO,表示要透明的——不要不透明的，scale表示比例因素，当前点与像素的比例，比如6p 1点对应3个像素，这里填0，自适应
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0);
    // 描述剪裁区域--用它来描述一个圆
    UIBezierPath * path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    
    // 设置裁剪区
    [path addClip];
    // 画图片
    [self drawAtPoint:CGPointZero];
    
    // 取出图片
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    // 关闭上下文
    UIGraphicsEndImageContext();

    return image;
}
+ (instancetype)tw_circleImageNamed:(NSString *)imageName{
    return [[self imageNamed:imageName] tw_circleImage];
}

@end
