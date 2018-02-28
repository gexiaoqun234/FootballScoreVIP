//
//  TWPhoneFollowDetailModel.h
//  105CP
//
//  Created by 田伟 on 2017/11/6.
//  Copyright © 2017年 宋辉. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TWPhoneFollowDetailResulltModel;
@class TWPhoneFollowDetailResultsModel;
@class TWPhoneFollowDetailUsertitlesModel;

@interface TWPhoneFollowDetailModel : NSObject

@property (nonatomic, copy) NSString * allnum;// 近7天总次数
@property (nonatomic, copy) NSString * hitnum;// 近7天中次数
@property (nonatomic, copy) NSString * cnickid;// uuid
@property (nonatomic, copy) NSString * cnickname;// 用户名
@property (nonatomic, copy) NSString * fsum;// 几连中
@property (nonatomic, copy) NSString * iallnumMonth;// 近30天总次数
@property (nonatomic, copy) NSString * ihitnumMonth;// 近30天中次数
@property (nonatomic, copy) NSString * iaward;// 创造价值
@property (nonatomic, copy) NSString * icopyaward;// 累计中奖
@property (nonatomic, copy) NSString * ifoucsnum;// 粉丝
@property (nonatomic, copy) NSString * ihitnum;
@property (nonatomic, copy) NSString * ihot;
@property (nonatomic, copy) NSString * imageUrl;
@property (nonatomic, copy) NSString * isAuto;
@property (nonatomic, copy) NSString * isfollow;
@property (nonatomic, copy) NSString * lotteryType;// "0"--竞彩足球
@property (nonatomic, copy) NSString * profit;// 单位回报率 %
@property (nonatomic, copy) NSString * zprofit_m;
// 近期战绩
@property (nonatomic, strong) NSArray <TWPhoneFollowDetailResultsModel *> * results;
@property (nonatomic, strong) NSArray * result;
@property (nonatomic, strong) NSArray * usertitles;


@end
