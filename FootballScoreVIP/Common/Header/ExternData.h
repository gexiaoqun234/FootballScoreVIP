//
//  ExternData.h
//  FootballScore
//
//  Created by 田伟 on 2018/2/27.
//  Copyright © 2018年 MG. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - ========固定常量值=======
UIKIT_EXTERN CGFloat const DiscoverCopyFollowHotListSection3Height;

#pragma mark - ========通知=======
// 红人点击通知
UIKIT_EXTERN NSString * const SHRedUserViewRedUserDidClickNotification;

// 专家名人点击通知
UIKIT_EXTERN NSString * const TWFamousListsDidClickNotification;



#pragma mark - ========接口=======
// 接口的头部——用来拼接网址
UIKIT_EXTERN NSString * const InterfaceHeader;

// 发现页面下复制跟单里的红人请求接口
UIKIT_EXTERN NSString * const DiscoverCopyFollowRedUserURL;

// 发现页面下复制跟单里的热门跟单请求接口
UIKIT_EXTERN NSString * const DiscoverCopyFollowHotListURL;

// 发现页面下复制跟单里的热门跟单请求接口
UIKIT_EXTERN NSString * const DiscoverCopyFollowHotListURL;

// 发现页面下复制跟单里的热门跟单显示全部的请求接口
UIKIT_EXTERN NSString * const DiscoverCopyFollowHotListShowMoreURL;

// 发现页面下复制跟单里的热门跟单显示详情的请求接口
UIKIT_EXTERN NSString * const DiscoverCopyFollowHotListShowDetailURL;

// 发现页面下复制跟单里的热门跟单显示详情里的跟单用户的请求接口
UIKIT_EXTERN NSString * const DiscoverCopyFollowHotListShowDetailUserListsURL;

// 发现页面下专家名人的请求接口
UIKIT_EXTERN NSString * const CelebrityExplanationFamousListsURL;

// 发现页面下名家解说的请求接口
UIKIT_EXTERN NSString * const CelebrityExplanationExplainListURL;

// 发现页面下复制跟单里的命中榜周榜请求接口
UIKIT_EXTERN NSString * const DiscoverCopyFollowWeekHitUserURL;

// 发现页面下复制跟单里的命中榜月榜请求接口
UIKIT_EXTERN NSString * const DiscoverCopyFollowMonthHitUserURL;

// 发现页面下复制跟单里的盈利榜周榜请求接口
UIKIT_EXTERN NSString * const DiscoverCopyFollowWeekProfitUserURL;

// 发现页面下复制跟单里的盈利榜月榜请求接口
UIKIT_EXTERN NSString * const DiscoverCopyFollowMonthProfitUserURL;

// 发现页面下复制跟单里的人物详情接口
UIKIT_EXTERN NSString * const DiscoverCopyFollowPhonefollowDetailURL;

// 发现页面下复制跟单里的人物详情底下的跟单列表接口
UIKIT_EXTERN NSString * const DiscoverCopyFollowPhonefollowDetailListURL;

// 发现页面下复制跟单里的每日足球竞彩接口
UIKIT_EXTERN NSString * const DiscoverCopyFollowjczqURL;

// 发现页面下复制跟单里的每日篮球竞彩接口
UIKIT_EXTERN NSString * const DiscoverCopyFollowjclqURL;

// 发现页面下复制跟单里的新闻资讯足球接口
UIKIT_EXTERN NSString * const DiscoverCopyFollowFootballURL;

// 发现页面下复制跟单里的新闻资讯蓝球接口
UIKIT_EXTERN NSString * const DiscoverCopyFollowBasketballURL;

// 发现页面下复制跟单里的新闻资讯数字彩接口
UIKIT_EXTERN NSString * const DiscoverCopyFollowszcURL;

// 发现页面下查看全部名家解说接口
UIKIT_EXTERN NSString * const DiscoverCopyFollowsCelebrityExplanationAllURL;

// 发现页面下查看全部名家解说详情接口
UIKIT_EXTERN NSString * const DiscoverCopyFollowsCelebrityExplanationDetailURL;

// 发现页面下查看全部名家列表接口
UIKIT_EXTERN NSString * const DiscoverCopyFollowsAllCelebrityListsURL;

// 发现页面下名家解说下名家详情接口
UIKIT_EXTERN NSString * const DiscoverCopyFollowsCelebrityDetailURL;


#pragma mark - ========CellID=======
// 发现-复制跟单-section3的cellId
UIKIT_EXTERN NSString * const CFTWHotLstCell;
UIKIT_EXTERN NSString * const EmptyCellID;
UIKIT_EXTERN NSString * const FourmCollectCellID;
UIKIT_EXTERN NSString * const IntegralCellID;
UIKIT_EXTERN NSString * const TWNewsCellID;

UIKIT_EXTERN NSString * const TWFamousListCellID;
UIKIT_EXTERN NSString * const TWExplainListCellID;
UIKIT_EXTERN NSString * const TWForecastCellID;

UIKIT_EXTERN NSString * const CFSectionOneCell;
UIKIT_EXTERN NSString * const CFSectionTwoCell;


UIKIT_EXTERN NSString * const TWLoginPhoneNumber;
UIKIT_EXTERN NSString * const TWLoginCode;
UIKIT_EXTERN NSString * const TWLoginStrTime;
UIKIT_EXTERN NSString * const TWLoginUsername;
UIKIT_EXTERN NSString * const TWLoginPassword;
UIKIT_EXTERN NSString * const TWBaseStr;
UIKIT_EXTERN NSString * const TWRealName;
UIKIT_EXTERN NSString * const TWIdCard;
UIKIT_EXTERN NSString * const TWOldPassword;
UIKIT_EXTERN NSString * const TWUserSign;


// 保存注册信息的关键字
UIKIT_EXTERN NSString * const TWUserID;
UIKIT_EXTERN NSString * const TWUsername;
UIKIT_EXTERN NSString * const TWScore;


// 刷新个人页面的通知
UIKIT_EXTERN NSString * const TWPersonageVcRefreshHeaderNotification;


// 请求地址
UIKIT_EXTERN NSString *  const TWLoginSendCodeUrl;
// 新用户注册
UIKIT_EXTERN NSString *  const TWLoginRegisterUrl;
// 用户登录
UIKIT_EXTERN NSString * const TWLoginUrl;
// 上传头像
UIKIT_EXTERN NSString * const TWuploadFileUrl;
// 绑定真实信息
UIKIT_EXTERN NSString * const TWBandRealInfoUrl;
// 退出登录
UIKIT_EXTERN NSString * const TWLoginOutUrl;
// 用户签到
UIKIT_EXTERN NSString * const TWUserSignUrl;
// 修改密码
UIKIT_EXTERN NSString * const TWChangeUserInfoUrl;
// 签名修改
UIKIT_EXTERN NSString * const TWchangeUserSignInfoUrl;
// 忘记密码
UIKIT_EXTERN NSString * const TWForgetPwdUrl;
// 积分明细
UIKIT_EXTERN NSString * const TWShowScoreDetailUrl;
// 个人中获取用户订单接口
UIKIT_EXTERN NSString * const PersonalGetUserOrdersURL;






