//
//  SHNetworkTool.h
//  105CP
//
//  Created by 田伟 on 2017/11/1.
//  Copyright © 2017年 宋辉. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
@class TWHotListDetail;
@class SHHotlistUserListModel;
@class TWPhoneFollowDetailModel;
@class TWExplanationDetailModel;
@class SHCelebrityDetailModel;

typedef NS_ENUM(NSInteger,RequestType) {
    GET = 0,
    POST = 1,
};

@interface SHNetworkTool : AFHTTPSessionManager

+ (SHNetworkTool *)shareInstance;
@property (nonatomic,assign) RequestType type;
- (void)requsetMethodType:(RequestType)type urlString:(NSString *)urlString parameters:(NSDictionary *)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError * error))failure;

#pragma mark - ========数据请求=======
// 发现页面——复制跟单——红人
- (void)getDiscoverCopyFollowRedUserDataSuccess:(void (^)(NSArray * redUserArray))success failure:(void (^)(NSError * error))failure;

// 发现页面——复制跟单——热门跟单
- (void)getDiscoverCopyFollowHotListDataSuccess:(void (^)(NSArray * hotListArray))success failure:(void (^)(NSError * error))failure;

// 发现页面——复制跟单——热门跟单显示全部
- (void)getDiscoverCopyFollowHotListShowMoreDataWith:(NSDictionary *)parameters Success:(void (^)(NSArray * hotListArray))success failure:(void (^)(NSError * error))failure;

// 发现页面——复制跟单——热门跟单显示详情
- (void)getDiscoverCopyFollowHotListShowDetailDataWith:(NSDictionary *)parameters Success:(void (^)(TWHotListDetail * datailData))success failure:(void (^)(NSError * error))failure;

// 发现页面——复制跟单——热门跟单显示详情——跟单用户
- (void)getDiscoverCopyFollowHotListShowDetailUserListDataWith:(NSDictionary *)parameters Success:(void (^)(SHHotlistUserListModel * userListsData))success failure:(void (^)(NSError * error))failure;

// 名家解说——专家名人 
- (void)getCelebrityExplanationFamousListsDataSuccess:(void (^)(NSArray * famousListsArray))success failure:(void (^)(NSError * error))failure;

// 名家解说——名家解说
- (void)getCelebrityExplanationExplainListDataSuccess:(void (^)(NSArray * ExplainListArray))success failure:(void (^)(NSError * error))failure;

// 发现页面——复制跟单——命中榜周榜
- (void)getDiscoverCopyFollowWeekHitUserDataSuccess:(void (^)(NSArray * weekHitUserArray))success failure:(void (^)(NSError * error))failure;

// 发现页面——复制跟单——命中榜月榜
- (void)getDiscoverCopyFollowMonthHitUserDataSuccess:(void (^)(NSArray * monthHitUserArray))success failure:(void (^)(NSError * error))failure;

// 发现页面——复制跟单——盈利榜周榜
- (void)getDiscoverCopyFollowWeekprofitUserDataSuccess:(void (^)(NSArray * weekproficUserArray))success failure:(void (^)(NSError * error))failure;

// 发现页面——复制跟单——盈利榜月榜
- (void)getDiscoverCopyFollowMonthprofitUserDataSuccess:(void (^)(NSArray * monthprofixUserArray))success failure:(void (^)(NSError * error))failure;

// 发现页面——复制跟单——人物详情
- (void)getDiscoverCopyFollowPhoneFollowDetailDataWith:(NSDictionary *)parameters Success:(void (^)(TWPhoneFollowDetailModel * phoneFollowDetailData))success failure:(void (^)(NSError * error))failure;

// 发现页面——复制跟单——人物详情地下的跟单列表
- (void)getDiscoverCopyFollowPhoneFollowDetailListDataWith:(NSDictionary *)parameters Success:(void (^)(NSArray * phoneFollowDetailListData))success failure:(void (^)(NSError * error))failure;

// 发现页面——每日竞彩
- (void)getDiscoverForecastDataWithURL:(NSString *)URL Success:(void (^)(NSArray * forecastArray))success failure:(void (^)(NSError * error))failure;

// 发现页面——新闻资讯
- (void)getDiscoverNewsDataWithURL:(NSString *)URL Success:(void (^)(NSArray * newsArray))success failure:(void (^)(NSError * error))failure;

// 发现页面——全部名家解说
- (void)getCelebrityExplanationAllCelebrityWith:(NSDictionary *)parameters Success:(void (^)(NSArray * allCelebrityArray))success failure:(void (^)(NSError * error))failure;

// 发现页面——全部名家详情解说
- (void)getCelebrityExplanationDetailDataWith:(NSDictionary *)parameters Success:(void (^)(TWExplanationDetailModel * explanationDetailModel))success failure:(void (^)(NSError * error))failure;

// 发现页面——全部名人列表
- (void)getDiscoverCopyFollowsAllCelebrityListsWith:(NSDictionary *)parameters Success:(void (^)(NSArray * celebrityListsArray))success failure:(void (^)(NSError * error))failure;

// 发现页面——专家名人详情解说
- (void)getDiscoverCopyFollowsCelebrityDetailWith:(NSDictionary *)parameters Success:(void (^)(SHCelebrityDetailModel * celebrityDetailModel))success failure:(void (^)(NSError * error))failure;


// 每日一单-期号
//- (void)getEveryDayPhaseListSuccess:(void (^)(id forecastArray))success failure:(void (^)(NSError * error))failure;

// 每日一单-详情



@end
