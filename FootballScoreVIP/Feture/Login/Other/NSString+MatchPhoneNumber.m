//
//  NSString+MatchPhoneNumber.m
//  QQCP
//
//  Created by 田伟 on 2017/6/29.
//  Copyright © 2017年 田伟. All rights reserved.
//

#import "NSString+MatchPhoneNumber.h"


@implementation NSString (MatchPhoneNumber)

+ (NSString *)valiMobile:(NSString *)mobile{
    if (mobile.length < 11) {
        return @"请输入正确的手机号";
        
    } else {
        /**
         * 移动号段正则表达式
         */
        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
        /**
         * 联通号段正则表达式
         */
        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        /**
         * 电信号段正则表达式
         */
        NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
        
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:mobile];
        
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:mobile];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:mobile];
        
        if (isMatch1 || isMatch2 || isMatch3) {
            if (isMatch1) {
                return @"合格";
            }else if (isMatch2) {
                return @"合格";
            }else {
                return @"合格";
            }
        }else{
            return @"请输入正确的手机号码";
        }
    }
    return nil;
}


+ (NSString *)VerificationCode:(NSString *)varification{
    NSString *str = @"^[0-9]*$";
    if (varification.length < 1) {
        return @"验证码输入有误";
    }else{
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", str];
        BOOL isMatch1 = [pred1 evaluateWithObject:varification];
        if (!isMatch1) {
            return @"验证码输入有误";
        }
    }
    return nil;
}


+ (NSString *)ValiName:(NSString *)name{
    if (name.length > 20 && name.length < 2) {
        return @"您输入的姓名不合法";
    }else{

        NSString *str = @"^[a-zA-Z\u4E00-\u9FA5]{1,20}";
        
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", str];
        BOOL isMatch1 = [pred1 evaluateWithObject:name];
        
        if (!isMatch1) {
            return @"您输入的姓名不合法";
        }
    }
    return nil;
}


+ (NSString *)filterHTML:(NSString *)html{
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    while([scanner isAtEnd]==NO){
        // 找到标签的起始位置
        [scanner scanUpToString:@"<" intoString:nil];
        // 找到标签的结束位置
        [scanner scanUpToString:@">" intoString:&text];
        // 替换字符
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
    return html;
}

// 根据字体大小计算文本的高度
+ (NSString *)calculateHeight:(NSString *)string withFontSize:(NSInteger)size{
    // 正文内容的size限制
    CGSize textMaxSize = CGSizeMake(TWScreenWidth - 2 * 10, MAXFLOAT);
    // 正文内容的高度
    CGFloat height = [string boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:size]} context:nil].size.height;
    return [NSString stringWithFormat:@"%f",height];
}

// 解码
+ (NSString *)base64DecodeString:(NSString *)string {
    //1.将base64编码后的字符串『解码』为二进制数据
    NSData *data = [[NSData alloc]initWithBase64EncodedString:string options:0];
    //2.把二进制数据转换为字符串返回
    return [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
}

// 编码
+ (NSString *)base64EncodeString:(NSString *)string{
    //1.先把字符串转换为二进制数据
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    //2.对二进制数据进行base64编码，返回编码后的字符串
    return [data base64EncodedStringWithOptions:0];
}


@end
