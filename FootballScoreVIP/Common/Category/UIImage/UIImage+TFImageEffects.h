//
//  UIImage+TFImageEffects.h
//  FlyMusic
//
//  Created by 谢腾飞 on 16/8/23.
//  Copyright © 2016年 谢腾飞. All rights reserved.
//

@import UIKit;

@interface UIImage (TFImageEffects)

- (UIImage *)applyLightEffect;
- (UIImage *)applyExtraLightEffect;
- (UIImage *)applyDarkEffect;
- (UIImage *)applyTintEffectWithColor:(UIColor *)tintColor;

- (UIImage *)applyBlurWithRadius:(CGFloat)blurRadius tintColor:(UIColor *)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage *)maskImage;

@end

