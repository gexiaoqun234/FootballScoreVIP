//
//  SHHotListModel.h
//  105CP
//
//  Created by 田伟 on 2017/11/1.
//  Copyright © 2017年 宋辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SHHotListModel : NSObject

/*
 "allnum": "2",
 "cendtime": "2017-11-02 23:50:00",
 "copycount": "419",
 "copysum": "26708",
 "hitnum": "1",
 "iaward": "393169.1",
 "icopyaward": "288369.12",
 "imageUrl": "/upload/userPic/11221299_5.png",
 "iorder": "0",
 "ireturnrate": "0",
 "ishot": "0",
 "itmoney": "100008",
 "iupload": "1",
 "lznum": "0",
 "nickname": "红单团",
 "note": "今晚的比赛临场单子！均注跟上这单！这单我有十足的把握，十拿九稳！",
 "perMoney": "2",
 "profit": "97",
 "projid": "70_CP70124063800",
 "time": "2017-11-02 00:45:43",
 "uid": "11221299"
 */


@property (nonatomic, copy) NSString * allnum;
@property (nonatomic, copy) NSString * cendtime;
@property (nonatomic, copy) NSString * copycount;
@property (nonatomic, copy) NSString * copysum;
@property (nonatomic, copy) NSString * hitnum;
@property (nonatomic, copy) NSString * iaward;
@property (nonatomic, copy) NSString * icopyaward;
@property (nonatomic, copy) NSString * imageUrl;
@property (nonatomic, copy) NSString * iorder;
@property (nonatomic, copy) NSString * ireturnrate;
@property (nonatomic, copy) NSString * ishot;
@property (nonatomic, copy) NSString * itmoney;
@property (nonatomic, copy) NSString * iupload;
@property (nonatomic, copy) NSString * lznum;
@property (nonatomic, copy) NSString * nickname;
@property (nonatomic, copy) NSString * note;
@property (nonatomic, copy) NSString * perMoney;
@property (nonatomic, copy) NSString * profit;
@property (nonatomic, copy) NSString * projid;
@property (nonatomic, copy) NSString * time;
@property (nonatomic, copy) NSString * uid;

@end
