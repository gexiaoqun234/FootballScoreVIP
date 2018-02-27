//
//  TWNewsModel.h
//  105CP
//
//  Created by 田伟 on 2017/11/6.
//  Copyright © 2017年 宋辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TWNewsModel : NSObject<NSCoding>

/*
 {
 "contents": "竞彩足球周一002：纽伦堡VS因戈尔施塔特 比赛时间：2017-11-07 星期二 03：00 赛事分析 ： 周二凌晨德乙联赛将展开本轮最后一战，纽",
 "image": "http://mapi.159cai.com/uploads/allimg/171106/2-1G106093619551-lp.png",
 "pubdate": "11-06",
 "title": "周一竞彩：纽伦堡可捍卫主场",
 "url": "http://mapi.159cai.com/discovery/news/football/2017/1106/31011.html"
 },
 */

@property (nonatomic, copy) NSString * contents;
@property (nonatomic, copy) NSString * image;
@property (nonatomic, copy) NSString * pubdate;
@property (nonatomic, copy) NSString * title;
@property (nonatomic, copy) NSString * url;

@end
