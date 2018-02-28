//
//  SHNetworkTool.m
//  105CP
//
//  Created by 田伟 on 2017/11/1.
//  Copyright © 2017年 宋辉. All rights reserved.
//

#import "SHNetworkTool.h"
#import "SHRedUserModel.h"
#import "SHHotListModel.h"
#import "TWHotListDetail.h"
#import "SHHotlistUserListModel.h"
#import "TWFamousListsModel.h"
#import "TWExplainListModel.h"
#import "TWHitModel.h"
#import "TWProfitModel.h"
#import "TWPhoneFollowDetailModel.h"
#import "TWNewsModel.h"
#import "TWForecastModel.h"
#import "TWFollowUserListModel.h"
#import "TWExplanationDetailModel.h"
#import "SHCelebrityDetailModel.h"

@implementation SHNetworkTool

+ (SHNetworkTool *)shareInstance{
    static SHNetworkTool * tool = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!tool) {
            tool = [[SHNetworkTool alloc]init];
            tool.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/plain",@"text/html",@"text/xml", nil];
        }
    });
    return tool;
}

- (void)requsetMethodType:(RequestType)type urlString:(NSString *)urlString parameters:(NSDictionary *)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError * error))failure{
    // 在进行本次请求之前，先将之前的所有请求取消掉
//    [self.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    if (type == GET) {
        [self GET:urlString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
            
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
    } else if (type == POST) {
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

- (void)getDiscoverCopyFollowRedUserDataSuccess:(void (^)(NSArray * redUserArray))success failure:(void (^)(NSError * error))failure{
    [self requsetMethodType:GET urlString:DiscoverCopyFollowRedUserURL parameters:nil success:^(id responseObject) {
        success([SHRedUserModel mj_objectArrayWithKeyValuesArray:responseObject]);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)getDiscoverCopyFollowHotListDataSuccess:(void (^)(NSArray * hotListArray))success failure:(void (^)(NSError * error))failure{
    [self requsetMethodType:GET urlString:DiscoverCopyFollowHotListURL parameters:nil success:^(id responseObject) {
        success([SHHotListModel mj_objectArrayWithKeyValuesArray:responseObject]);
    } failure:^(NSError *error) {
        failure(error);
    }];
}


- (void)getDiscoverCopyFollowHotListShowMoreDataWith:(NSDictionary *)parameters Success:(void (^)(NSArray * hotListArray))success failure:(void (^)(NSError * error))failure{
    [self requsetMethodType:GET urlString:DiscoverCopyFollowHotListShowMoreURL parameters:parameters success:^(id responseObject) {
        success([SHHotListModel mj_objectArrayWithKeyValuesArray:responseObject]);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)getDiscoverCopyFollowHotListShowDetailDataWith:(NSDictionary *)parameters Success:(void (^)(TWHotListDetail * datailData))success failure:(void (^)(NSError * error))failure{
    [self requsetMethodType:GET urlString:DiscoverCopyFollowHotListShowDetailURL parameters:parameters success:^(id responseObject) {
        success([TWHotListDetail mj_objectWithKeyValues:responseObject]);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)getDiscoverCopyFollowHotListShowDetailUserListDataWith:(NSDictionary *)parameters Success:(void (^)(SHHotlistUserListModel * userListsData))success failure:(void (^)(NSError * error))failure{
    [self requsetMethodType:GET urlString:DiscoverCopyFollowHotListShowDetailUserListsURL parameters:parameters success:^(id responseObject) {
        success([SHHotlistUserListModel mj_objectWithKeyValues:responseObject]);
    } failure:^(NSError *error) {
        failure(error);
    }];
}


- (void)getCelebrityExplanationFamousListsDataSuccess:(void (^)(NSArray * famousListsArray))success failure:(void (^)(NSError * error))failure{
    [self requsetMethodType:GET urlString:CelebrityExplanationFamousListsURL parameters:nil success:^(id responseObject) {
        success([TWFamousListsModel mj_objectArrayWithKeyValuesArray:responseObject]);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)getCelebrityExplanationExplainListDataSuccess:(void (^)(NSArray * ExplainListArray))success failure:(void (^)(NSError * error))failure{
    [self requsetMethodType:GET urlString:CelebrityExplanationExplainListURL parameters:nil success:^(id responseObject) {
        success([TWExplainListModel mj_objectArrayWithKeyValuesArray:responseObject]);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)getDiscoverCopyFollowWeekHitUserDataSuccess:(void (^)(NSArray * weekHitUserArray))success failure:(void (^)(NSError * error))failure{
    [self requsetMethodType:GET urlString:DiscoverCopyFollowWeekHitUserURL parameters:nil success:^(id responseObject) {
        success([TWHitModel mj_objectArrayWithKeyValuesArray:responseObject]);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)getDiscoverCopyFollowMonthHitUserDataSuccess:(void (^)(NSArray * monthHitUserArray))success failure:(void (^)(NSError * error))failure{
    [self requsetMethodType:GET urlString:DiscoverCopyFollowMonthHitUserURL parameters:nil success:^(id responseObject) {
        success([TWHitModel mj_objectArrayWithKeyValuesArray:responseObject]);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)getDiscoverCopyFollowWeekprofitUserDataSuccess:(void (^)(NSArray * weekproficUserArray))success failure:(void (^)(NSError * error))failure{
    [self requsetMethodType:GET urlString:DiscoverCopyFollowWeekProfitUserURL parameters:nil success:^(id responseObject) {
        success([TWProfitModel mj_objectArrayWithKeyValuesArray:responseObject]);
    } failure:^(NSError *error) {
        failure(error);
    }];
}


- (void)getDiscoverCopyFollowMonthprofitUserDataSuccess:(void (^)(NSArray * monthprofixUserArray))success failure:(void (^)(NSError * error))failure{
    [self requsetMethodType:GET urlString:DiscoverCopyFollowMonthProfitUserURL parameters:nil success:^(id responseObject) {
        success([TWProfitModel mj_objectArrayWithKeyValuesArray:responseObject]);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)getDiscoverCopyFollowPhoneFollowDetailDataWith:(NSDictionary *)parameters Success:(void (^)(TWPhoneFollowDetailModel * phoneFollowDetailData))success failure:(void (^)(NSError * error))failure{
    [self requsetMethodType:GET urlString:DiscoverCopyFollowPhonefollowDetailURL parameters:parameters success:^(id responseObject) {
        success([TWPhoneFollowDetailModel mj_objectWithKeyValues:responseObject]);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)getDiscoverCopyFollowPhoneFollowDetailListDataWith:(NSDictionary *)parameters Success:(void (^)(NSArray * phoneFollowDetailListData))success failure:(void (^)(NSError * error))failure{
    [self requsetMethodType:GET urlString:DiscoverCopyFollowPhonefollowDetailListURL parameters:parameters success:^(id responseObject) {
        success([TWFollowUserListModel mj_objectArrayWithKeyValuesArray:responseObject]);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)getDiscoverForecastDataWithURL:(NSString *)URL Success:(void (^)(NSArray * forecastArray))success failure:(void (^)(NSError * error))failure{
    [self requsetMethodType:GET urlString:URL parameters:nil success:^(id responseObject) {
        success([TWForecastModel mj_objectArrayWithKeyValuesArray:responseObject]);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)getDiscoverNewsDataWithURL:(NSString *)URL Success:(void (^)(NSArray * newsArray))success failure:(void (^)(NSError * error))failure{
    [self requsetMethodType:GET urlString:URL parameters:nil success:^(id responseObject) {
        success([TWNewsModel mj_objectArrayWithKeyValuesArray:responseObject]);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)getCelebrityExplanationAllCelebrityWith:(NSDictionary *)parameters Success:(void (^)(NSArray * allCelebrityArray))success failure:(void (^)(NSError * error))failure{
    [self requsetMethodType:GET urlString:DiscoverCopyFollowsCelebrityExplanationAllURL parameters:parameters success:^(id responseObject) {
        success([TWExplainListModel mj_objectArrayWithKeyValuesArray:responseObject]);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)getCelebrityExplanationDetailDataWith:(NSDictionary *)parameters Success:(void (^)(TWExplanationDetailModel * explanationDetailModel))success failure:(void (^)(NSError * error))failure{
    [self requsetMethodType:GET urlString:DiscoverCopyFollowsCelebrityExplanationDetailURL parameters:parameters success:^(id responseObject) {
        success([TWExplanationDetailModel mj_objectWithKeyValues:responseObject]);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)getDiscoverCopyFollowsAllCelebrityListsWith:(NSDictionary *)parameters Success:(void (^)(NSArray * celebrityListsArray))success failure:(void (^)(NSError * error))failure{
    [self requsetMethodType:GET urlString:DiscoverCopyFollowsAllCelebrityListsURL parameters:parameters success:^(id responseObject) {
        success([TWFamousListsModel mj_objectArrayWithKeyValuesArray:responseObject]);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)getDiscoverCopyFollowsCelebrityDetailWith:(NSDictionary *)parameters Success:(void (^)(SHCelebrityDetailModel * celebrityDetailModel))success failure:(void (^)(NSError * error))failure{
    [self requsetMethodType:GET urlString:DiscoverCopyFollowsCelebrityDetailURL parameters:parameters success:^(id responseObject) {
        success([SHCelebrityDetailModel mj_objectWithKeyValues:responseObject]);
    } failure:^(NSError *error) {
        failure(error);
    }];
}


//- (void)getEveryDayPhaseListSuccess:(void (^)(id forecastArray))success failure:(void (^)(NSError * error))failure{
//    
//    self.requestSerializer=[AFHTTPRequestSerializer serializer];
//    self.responseSerializer = [AFJSONResponseSerializer serializer];
//    self.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
//    
//    [self requsetMethodType:GET urlString:EveryDayPhaseListUrl parameters:nil success:^(id responseObject) {
//        // 查询参数异常!
//        TWLog(@"%@",responseObject);
//        
//    } failure:^(NSError *error) {
//        failure(error);
//    }];
//}







@end
