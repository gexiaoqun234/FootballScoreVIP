//
//  TWLoginNetworkTool.m
//  105CP
//
//  Created by 田伟 on 2017/11/15.
//  Copyright © 2017年 宋辉. All rights reserved.
//

#import "TWLoginNetworkTool.h"

@implementation TWLoginNetworkTool

+ (TWLoginNetworkTool *)shareInstance{
    static TWLoginNetworkTool * tool = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!tool) {
            tool = [[TWLoginNetworkTool alloc]init];
            tool.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/plain",@"text/html", nil];
        }
    });
    return tool;
}

- (void)requsetMethodType:(TWLoginRequestType)type urlString:(NSString *)urlString parameters:(NSDictionary *)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError * error))failure{
    // 在进行本次请求之前，先将之前的所有请求取消掉
    [self.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    if (type == LoginGET) {
        [self GET:urlString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (success) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (failure) {
                if (error.code == NSURLErrorNetworkConnectionLost) {
//                    [SVProgressHUD showErrorWithStatus:@"网络连接丢失，请稍后再试~"];
//                    [SVProgressHUD dismissWithDelay:0.5];
                } else if (error.code == NSURLErrorTimedOut) {
                    [SVProgressHUD showErrorWithStatus:@"请求超时，请重新下拉刷新~"];
                    [SVProgressHUD dismissWithDelay:0.5];
                } else if (error.code == NSURLErrorCancelled) {
                    TWLog(@"主动取消任务导致的error");
                } else {
                    [SVProgressHUD showErrorWithStatus:@"请求失败~"];
                    [SVProgressHUD dismissWithDelay:0.5];
                    TWLog(@"请求失败的原因—————— %@",error);
                    failure(error);
                }
            }
        }];
    } else if (type == LoginPOST) {
        [self POST:urlString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (success) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (failure) {
                if (error.code == NSURLErrorNetworkConnectionLost) {
                    [SVProgressHUD showErrorWithStatus:@"网络连接丢失，请稍后再试~"];
                    [SVProgressHUD dismissWithDelay:0.5];
                } else if (error.code == NSURLErrorTimedOut) {
                    [SVProgressHUD showErrorWithStatus:@"请求超时，请重新下拉刷新~"];
                    [SVProgressHUD dismissWithDelay:0.5];
                } else if (error.code == NSURLErrorCancelled) {
                    TWLog(@"主动取消任务导致的error");
                } else {
                    [SVProgressHUD showErrorWithStatus:@"请求失败~"];
                    [SVProgressHUD dismissWithDelay:0.5];
                    TWLog(@"请求失败的原因—————— %@",error);
                    failure(error);
                }
            }
        }];
    }
}


@end
