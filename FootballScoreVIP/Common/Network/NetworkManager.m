//
//  NetworkManager.m
//  FootballScore
//
//  Created by 田伟 on 2018/2/27.
//  Copyright © 2018年 MG. All rights reserved.
//

#import "NetworkManager.h"

@interface NetworkManager()
@property (nonatomic, strong) AFHTTPSessionManager * sessionManager;
@property (nonatomic, strong) AFJSONResponseSerializer *jsonResponseSerializer;
@property (nonatomic, strong) AFHTTPResponseSerializer *httpResponseSerializer;
@end

@implementation NetworkManager

+ (instancetype)shareInstance{
    static NetworkManager * manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (manager == nil) {
            manager = [[NetworkManager alloc]init];
            manager.sessionManager = [AFHTTPSessionManager manager];
            manager.sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/plain",@"text/html",@"text/xml", nil];
        }
    });
    return manager;
}

// 设置请求的cookie
- (void)tw_setRequestCookie:(NSString *)cookie{
    [self.sessionManager.requestSerializer setValue:cookie forHTTPHeaderField:@"Cookie"];
}


- (NSURLSessionDataTask *)get:(NSString *)url params:(id)params success:(NetworkSuccessHandle)success failure:(NetworkFailureHandle)failure{
    TWLogFunc
//    [self configResponseForType:responseType];
    return [self.sessionManager GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject, task);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error, task);
        }
    }];
}

- (NSURLSessionDataTask *)post:(NSString *)url params:(id)params success:(NetworkSuccessHandle)success failure:(NetworkFailureHandle)failure{
//    [self configResponseForType:responseType];
    return [self.sessionManager POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject, task);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error, task);
        }
    }];
}


// 配置请求类型
//- (void)configResponseForType:(TWResponseType)type{
//    switch (type) {
//        case TWResponseTypeJSON:
//            self.sessionManager.responseSerializer = self.jsonResponseSerializer;
//            break;
//        case TWResponseTypeHTTP:
//            self.sessionManager.responseSerializer = self.httpResponseSerializer;
//            break;
//        default:
//            break;
//    }
//}

#pragma mark - getters
- (AFJSONResponseSerializer *)jsonResponseSerializer {
    if (_jsonResponseSerializer == nil) {
        _jsonResponseSerializer = [AFJSONResponseSerializer serializer];
    }
    return _jsonResponseSerializer;
}

- (AFHTTPResponseSerializer *)httpResponseSerializer {
    if (_httpResponseSerializer == nil) {
        _httpResponseSerializer = [AFHTTPResponseSerializer serializer];
    }
    return _httpResponseSerializer;
}

#pragma mark - network state
/**
 监视网络状况
 */
- (void)startMonitorNetworkType {
    [GLobalRealReachability startNotifier];
    [[[[NSNotificationCenter defaultCenter]
       rac_addObserverForName:kRealReachabilityChangedNotification object:nil]
      distinctUntilChanged]
     subscribeNext:^(NSNotification *notification) {
         RealReachability *reachability = (RealReachability *)notification.object;
         ReachabilityStatus status = [reachability currentReachabilityStatus];
         NSString *state;
         BOOL isReachable = YES;
         BOOL isNeeNotice = YES;
         switch (status) {
             case RealStatusNotReachable:
             {
                 state = @"网络已断开";
                 isReachable = NO;
             }
                 break;
             case RealStatusViaWiFi:
             {
                 state = @"已切换到 WIFI";
             }
                 break;
             case RealStatusViaWWAN:
             {
                 WWANAccessType accessType = [GLobalRealReachability currentWWANtype];
                 if (accessType == WWANType2G)
                 {
                     state = @"已切换到 2G";
                 }
                 else if (accessType == WWANType3G)
                 {
                     state = @"已切换到 3G";
                 }
                 else if (accessType == WWANType4G)
                 {
                     state = @"已切换到 4G";
                 }
             }
                 break;
             default:
             {
                 isNeeNotice = NO;
             }
                 break;
         }
         
         if (isNeeNotice) {
             if (isReachable) {
                 [SVProgressHUD showImage:[UIImage imageNamed:@"notice_type_warnning"] status:state];
                 
             }else {
                 [SVProgressHUD showImage:[UIImage imageNamed:@"notice_type_error"] status:state];
             }
         }
     }];
}

- (BOOL)isWIFI {
    if ([GLobalRealReachability currentReachabilityStatus] == RealStatusViaWiFi) {
        return YES;
    }else {
        return NO;
    }
}


@end
