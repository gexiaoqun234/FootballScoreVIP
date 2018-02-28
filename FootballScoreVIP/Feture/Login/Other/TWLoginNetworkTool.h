//
//  TWLoginNetworkTool.h
//  105CP
//
//  Created by 田伟 on 2017/11/15.
//  Copyright © 2017年 宋辉. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

#pragma mark - ========登录注册相关的网络请求=======
typedef NS_ENUM(NSInteger,TWLoginRequestType) {
    LoginGET = 0,
    LoginPOST = 1,
};

@interface TWLoginNetworkTool : AFHTTPSessionManager

+ (TWLoginNetworkTool *)shareInstance;
@property (nonatomic,assign) TWLoginRequestType type;
- (void)requsetMethodType:(TWLoginRequestType)type urlString:(NSString *)urlString parameters:(NSDictionary *)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError * error))failure;

@end
