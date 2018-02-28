//
//  TWFamousListsModel.h
//  105CP
//
//  Created by 田伟 on 2017/11/3.
//  Copyright © 2017年 宋辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TWFamousListsModel : NSObject
/*
 {
 "allnum": "7",
 "authadvantage": "日职,巴甲,俄超",
 "authdescription": "从事足球相关工作近20年，拥有众多俱乐部消息资源，善于利用欧赔和亚盘变化分析比赛，把足彩当理财投资工具，长期拥有稳定的高盈利率。",
 "authheadImlUrl": "http://m.aicaicdn.com/upload/memberphoto/152/tn_1499068597043_160_160.jpg",
 "authName": "尤利Ярослав",
 "authsummary": "",
 "authTag": "专业玩家",
 "explans": "0",
 "hitnum": "6",
 "jtype": "0",
 "lznum": "1"
 },
 */

@property (nonatomic, copy) NSString * allnum;
@property (nonatomic, copy) NSString * authadvantage;
@property (nonatomic, copy) NSString * authdescription;
@property (nonatomic, copy) NSString * authheadImlUrl;
@property (nonatomic, copy) NSString * authName;
@property (nonatomic, copy) NSString * authsummary;
@property (nonatomic, copy) NSString * authTag;
@property (nonatomic, copy) NSString * explans;
@property (nonatomic, copy) NSString * hitnum;
@property (nonatomic, copy) NSString * jtype;
@property (nonatomic, copy) NSString * lznum;

@end
