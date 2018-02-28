//
//  AccountTool.h
//  QQCP30
//
//  Created by 田伟 on 2017/7/20.
//  Copyright © 2017年 魔曦. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AccountModel;

@interface AccountTool : NSObject

+ (AccountTool *)sharedAccountTool;

@property (nonatomic, assign) BOOL isLogin;
@property (nonatomic, copy) NSString * accountPath;
@property (nonatomic, strong) AccountModel * accountModel;

- (AccountModel *)readAccount;
- (BOOL)deleteAccount;

@end
