//
//  AccountModel.m
//  QQCP30
//
//  Created by 田伟 on 2017/7/20.
//  Copyright © 2017年 魔曦. All rights reserved.
//

#import "AccountModel.h"

@implementation AccountModel


// 解码
- (instancetype)initWithCoder:(NSCoder *)coder{
    self = [super init];
    if (self) {
        _username = [coder decodeObjectForKey:@"username"];
        _phoneNumber = [coder decodeObjectForKey:@"phoneNumber"];
        _userId = [coder decodeObjectForKey:@"userId"];
        _imgPath = [coder decodeObjectForKey:@"imgPath"];
        _score = [coder decodeObjectForKey:@"score"];
        _userSign = [coder decodeObjectForKey:@"userSign"];
        _isBinding = [coder decodeObjectForKey:@"isBinding"];
        _level = [coder decodeObjectForKey:@"level"];
        _userRealName = [coder decodeObjectForKey:@"userRealName"];
        _bandPhoneNumber = [coder decodeObjectForKey:@"bandPhoneNumber"];
        _userIdCard = [coder decodeObjectForKey:@"userIdCard"];
        _isSign = [coder decodeObjectForKey:@"isSign"];
        _isLogin = [coder decodeObjectForKey:@"isLogin"];
        _tw_possword = [coder decodeObjectForKey:@"tw_possword"];
        _token = [coder decodeObjectForKey:@"token"];
        _saveTime = [coder decodeObjectForKey:@"saveTime"];
    }
    return self;
}

// 编码
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:_username forKey:@"username"];
    [aCoder encodeObject:_phoneNumber forKey:@"phoneNumber"];
    [aCoder encodeObject:_userId forKey:@"userId"];
    [aCoder encodeObject:_imgPath forKey:@"imgPath"];
    [aCoder encodeObject:_score forKey:@"score"];
    [aCoder encodeObject:_userSign forKey:@"userSign"];
    [aCoder encodeObject:_isBinding forKey:@"isBinding"];
    [aCoder encodeObject:_level forKey:@"level"];
    [aCoder encodeObject:_userRealName forKey:@"userRealName"];
    [aCoder encodeObject:_bandPhoneNumber forKey:@"bandPhoneNumber"];
    [aCoder encodeObject:_userIdCard forKey:@"userIdCard"];
    [aCoder encodeObject:[NSString stringWithFormat:@"%@",_isSign] forKey:@"isSign"];
    [aCoder encodeObject:_isLogin forKey:@"isLogin"];
    [aCoder encodeObject:_tw_possword forKey:@"tw_possword"];
    [aCoder encodeObject:_token forKey:@"token"];
    [aCoder encodeObject:_saveTime forKey:@"saveTime"];
}

//- (NSDate *)saveTime{
//    return [NSDate date];
//}


@end
