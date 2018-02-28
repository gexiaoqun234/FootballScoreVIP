//
//  AccountModel.h
//  QQCP30
//
//  Created by 田伟 on 2017/7/20.
//  Copyright © 2017年 魔曦. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccountModel : NSObject<NSCoding>
/** 用户名（昵称） */
@property (nonatomic, copy) NSString * username;
/** 用户手机号码 */
@property (nonatomic, copy) NSString * phoneNumber;
/** 用户id */
@property (nonatomic, copy) NSString * userId;
/** 用户头像url */
@property (nonatomic, copy) NSString * imgPath;
/** 用户积分 */
@property (nonatomic, copy) NSString * score;
/** 用户签名 */
@property (nonatomic, copy) NSString * userSign;
/** 用户是否绑定真实信息（0：未绑定，1：已绑定） */
@property (nonatomic, copy) NSString * isBinding;
/** 用户等级 */
@property (nonatomic, copy) NSString * level;
/** 用户真实姓名 */
@property (nonatomic, copy) NSString * userRealName;
/** 用户绑定的电话号码 */
@property (nonatomic, copy) NSString * bandPhoneNumber;
/** 用户身份证号码 */
@property (nonatomic, copy) NSString * userIdCard;
/** 用户签到与否（0：未签到，1：已签到） */
@property (nonatomic, copy) NSString * isSign;
/** 用户是否已登录FLG（0：未登录，1：已登录） */
@property (nonatomic, copy) NSString * isLogin;

/** 自定义的————用户的登录密码 */
@property (nonatomic, copy) NSString * tw_possword;

/** token*/
@property (nonatomic, copy) NSString * token;

/** 记录时间戳*/
@property (nonatomic, copy) NSDate * saveTime;

@end
