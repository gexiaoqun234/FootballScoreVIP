//
//  TWExplainListModel.h
//  105CP
//
//  Created by 田伟 on 2017/11/3.
//  Copyright © 2017年 宋辉. All rights reserved.
//

#import <Foundation/Foundation.h>

// 全部名家解说分五种类型
typedef NS_ENUM(NSUInteger, ExplainListType) {
    // 全部
    ExplainListTypeAll = 0,
    // 竞足
    ExplainListTypeFootball = 1,
    // 竞蓝
    ExplainListTypeBaseball = 2,
    // 胜负彩
    ExplainListTypeNumber = 3,
    // 任选9
    ExplainListTypeChoose = 4
};

@interface TWExplainListModel : NSObject

/*
 {
 "allnum": "0",
 "authdescription": "彩票媒体编辑，长期关注日本足球联赛。谁说玩波女子不如男？",
 "authheadImlUrl": "http://m.aicaicdn.com/upload/memberphoto/452/tn_1489544603790_160_160.jpg",
 "authName": "玩波虎牙妹",
 "authsummary": "",
 "authTag": "专业玩家",
 "begintime": "2017-11-04 03:00:00",
 "dbno": "20171103125170",
 "endtime": "2017-11-04 05:00:00",
 "hitnum": "0",
 "isSee": "0",
 "jtype": "0",
 "lotterytype": "1",
 "lznum": "",
 "salepeice": "58",
 "timeType": "1",
 "title": "【虎牙妹推波】昨天高赔二串一命中，今天稳胆再来！"
 },
 */

@property (nonatomic, copy) NSString * allnum;
@property (nonatomic, copy) NSString * authdescription;
@property (nonatomic, copy) NSString * authheadImlUrl;
@property (nonatomic, copy) NSString * authName;
@property (nonatomic, copy) NSString * authsummary;
@property (nonatomic, copy) NSString * authTag;
@property (nonatomic, copy) NSString * begintime;
@property (nonatomic, copy) NSString * dbno;
@property (nonatomic, copy) NSString * endtime;
@property (nonatomic, copy) NSString * hitnum;
@property (nonatomic, copy) NSString * isSee;
@property (nonatomic, copy) NSString * jtype;
@property (nonatomic, copy) NSString * lotterytype;
@property (nonatomic, copy) NSString * salepeice;
@property (nonatomic, copy) NSString * timeType;
@property (nonatomic, copy) NSString * title;
@property (nonatomic, copy) NSString * lznum;

@end
