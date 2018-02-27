//
//  NetworkManager.h
//  FootballScore
//
//  Created by 田伟 on 2018/2/27.
//  Copyright © 2018年 MG. All rights reserved.
//

#import <Foundation/Foundation.h>

#define TWNETWROK [NetworkManager shareInstance]

typedef NS_ENUM(NSInteger ,TWResponseType) {
    TWResponseTypeJSON,
    TWResponseTypeHTTP
};

typedef void(^NetworkSuccessHandle)(id result, NSURLSessionDataTask * task);
typedef void(^NetworkFailureHandle)(NSError * error, NSURLSessionDataTask * task);

@interface NetworkManager : NSObject

+ (instancetype)shareInstance;

/**
 启动监视网络
 */
- (void)startMonitorNetworkType;


/**
 Judge is wifi ?
 
 @return isWifi
 */
- (BOOL)isWIFI;


/**
 设置请求 cookie
 
 @param cookie cookie
 */
- (void)tw_setRequestCookie:(NSString *)cookie;

- (NSURLSessionDataTask *)get:(NSString *)url
                       params:(id)params
                 responseType:(TWResponseType)responseType
                      success:(NetworkSuccessHandle)success
                      failure:(NetworkFailureHandle)failure;

- (NSURLSessionDataTask *)post:(NSString *)url
                        params:(id)params
                  responseType:(TWResponseType)responseType
                       success:(NetworkSuccessHandle)success
                       failure:(NetworkFailureHandle)failure;



@end
