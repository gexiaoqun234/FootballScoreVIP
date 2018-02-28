//
//  AccountTool.m
//  QQCP30
//
//  Created by 田伟 on 2017/7/20.
//  Copyright © 2017年 魔曦. All rights reserved.
//

#import "AccountTool.h"

@implementation AccountTool

- (NSString *)accountPath{
    if (_accountPath == nil) {
        _accountPath = [NSString stringWithFormat:@"%@/account.plist",[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]];
        TWLog(@"%@",_accountPath);
    }
    return _accountPath;
}

+ (AccountTool *)sharedAccountTool{
    static AccountTool * tool = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!tool) {
            tool = [[AccountTool alloc]init];
        }
    });
    return tool;
}

- (BOOL)isLogin{
    if ([self readAccount] == nil) {
        return NO;
    }
    return YES;
}


- (AccountModel *)readAccount{
    /*
     归档和解档的方法中，没有直接归档字符串和接档字符串的方法，只能直接将对象进行归档和接档。
     那么，如果将字符串的数字进行归档的话，接档处理后，字符串的数字会被转成NSNumber类型的对象。
     在后续的操作中，如果还当字符串进行比对的话，会报
     [__NSCFNumber isEqualToString:]: unrecognized selector sent to instance
     错误
     因此:我这将拿到的接档后的模型又全部转成字符串，可以保持一致。
     */
    AccountModel * model = [NSKeyedUnarchiver unarchiveObjectWithFile:self.accountPath];
    if (model) {
        AccountModel * strModel = [[AccountModel alloc]init];
        strModel.username = [NSString stringWithFormat:@"%@",model.username];
        strModel.phoneNumber = [NSString stringWithFormat:@"%@",model.phoneNumber];
        strModel.userId = [NSString stringWithFormat:@"%@",model.userId];
        strModel.imgPath = [NSString stringWithFormat:@"%@",model.imgPath];
        strModel.score = [NSString stringWithFormat:@"%@",model.score];
        strModel.isBinding = [NSString stringWithFormat:@"%@",model.isBinding];
        strModel.level = [NSString stringWithFormat:@"%@",model.level];
        strModel.userRealName = [NSString stringWithFormat:@"%@",model.userRealName];
        strModel.bandPhoneNumber = [NSString stringWithFormat:@"%@",model.bandPhoneNumber];
        strModel.userIdCard = [NSString stringWithFormat:@"%@",model.userIdCard];
        strModel.isSign = [NSString stringWithFormat:@"%@",model.isSign];
        strModel.isLogin = [NSString stringWithFormat:@"%@",model.isLogin];
        strModel.tw_possword = [NSString stringWithFormat:@"%@",model.tw_possword];
        strModel.userSign = [NSString stringWithFormat:@"%@",model.userSign];
        strModel.token = [NSString stringWithFormat:@"%@",model.token];
//        strModel.saveTime = [NSString stringWithFormat:@"%@",model.saveTime];
        strModel.saveTime = model.saveTime;
        return strModel;
    }
    return model;
}

- (BOOL)deleteAccount{
    if ([[NSFileManager defaultManager] isDeletableFileAtPath:self.accountPath]) {
        [[NSFileManager defaultManager] removeItemAtPath:self.accountPath error:nil];
        return YES;
    } else {
        return NO;
    }
}

@end
