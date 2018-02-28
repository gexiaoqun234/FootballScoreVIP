//
//  NSString+MatchPhoneNumber.h
//  QQCP
//
//  Created by 田伟 on 2017/6/29.
//  Copyright © 2017年 田伟. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MatchPhoneNumber)

/**
 *  正则表达式检测手机号码
 *
 *  @param mobile 传入手机号码
 *
 *  @return 返回检测信息
 */
+ (NSString *)valiMobile:(NSString *)mobile;

/**
 *  验证码码的验证
 *
 *  @param varification 传入的验证码
 *
 *  @return 返回的检测信息
 */
+ (NSString *)VerificationCode:(NSString *)varification;

/**
 *  验证姓名
 *
 *  @param name 姓名
 *
 *  @return 返回检测信息
 */
+ (NSString *)ValiName:(NSString *)name;

// 去掉字符串中HTML标签
+ (NSString *)filterHTML:(NSString *)html;

// 根据字体大小计算文本的高度
+ (NSString *)calculateHeight:(NSString *)string withFontSize:(NSInteger)size;

// 解码
+ (NSString *)base64DecodeString:(NSString *)string;
// 编码
+ (NSString *)base64EncodeString:(NSString *)string;
    
@end
