//
//  TWForecastModel.h
//  105CP
//
//  Created by 田伟 on 2017/11/6.
//  Copyright © 2017年 宋辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TWForecastModel : NSObject
/*
 {
 "expertabstract": "切奥尔雷上轮资格赛与波士顿联队两回合打成平手，双方进入加时赛，加时赛当中切奥尔雷表现更为出色，最终以3比4淘汰对手，晋级到足总杯正赛",
 "expertaddtitle": "竞彩足球003 23:50截止",
 "expertbet": "乔利主场不败可期",
 "experthit": "0",
 "experthot": "2",
 "experttitle": "乔利主场不败可期",
 "image": "http://m.159cai.com/uploads/171106/2-1G106134343O4.jpg",
 "url": "http://m.159cai.com/discovery/forecast/jczq/2017/1106/31021.html"
 },
 */

@property (nonatomic, copy) NSString * expertabstract;
@property (nonatomic, copy) NSString * expertaddtitle;
@property (nonatomic, copy) NSString * expertbet;
@property (nonatomic, copy) NSString * experthit;
@property (nonatomic, copy) NSString * experthot;
@property (nonatomic, copy) NSString * experttitle;
@property (nonatomic, copy) NSString * image;
@property (nonatomic, copy) NSString * url;

@end
