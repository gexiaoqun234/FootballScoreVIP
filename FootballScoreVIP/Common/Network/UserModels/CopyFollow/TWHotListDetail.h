//
//  TWHotListDetail.h
//  105CP
//
//  Created by 田伟 on 2017/11/2.
//  Copyright © 2017年 宋辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TWHotListDetail : NSObject

#pragma mark - ========不同=======
// ☆"codes": "",
@property (nonatomic, copy) NSString * codes;
@property (nonatomic, strong) NSArray * matchorder;

#pragma mark - ========相同=======
// myLottery:
@property (nonatomic, strong) NSArray * myLottery;
// "addtime": "2017-11-02 00:45:43",
@property (nonatomic, copy) NSString * addtime;
// "addtional": "0",
@property (nonatomic, copy) NSString * addtional;
// "allnum": "2",
@property (nonatomic, copy) NSString * allnum;
// "amoney": 0,
@property (nonatomic, copy) NSString * amoney;
// "author": "红单团",
@property (nonatomic, copy) NSString * author;
// "cancopy": "1",
@property (nonatomic, copy) NSString * cancopy;
// "cast": 3,
@property (nonatomic, copy) NSString * cast;
// "cdesc": "今晚的比赛临场单子！均注跟上这单！这单我有十足的把握，十拿九稳！",
@property (nonatomic, copy) NSString * cdesc;
// "cname": "",
@property (nonatomic, copy) NSString * cname;
// "copy": "2",
@property (nonatomic, copy) NSString * tw_copy;
// "copycount": "749",
@property (nonatomic, copy) NSString * copycount;
// "copysum": "40822",
@property (nonatomic, copy) NSString * copysum;
// "endtime": "2017-11-02 23:50:00",
@property (nonatomic, copy) NSString * endtime;
// "gameid": "70",
@property (nonatomic, copy) NSString * gameid;
// "gameName": "竞彩-混投",
@property (nonatomic, copy) NSString * gameName;
// "gold": "2",
@property (nonatomic, copy) NSString * gold;
// "hitnum": "1",
@property (nonatomic, copy) NSString * hitnum;
// "hot": "0",
@property (nonatomic, copy) NSString * hot;
// "iaward": "288369.12",
@property (nonatomic, copy) NSString * iaward;
// "ibonus": 0,
@property (nonatomic, copy) NSString * ibonus;
// "icopyaward": "393169.1",
@property (nonatomic, copy) NSString * icopyaward;
// "ifile": "0",
@property (nonatomic, copy) NSString * ifile;
// "ifoucsnum": "2460",
@property (nonatomic, copy) NSString * ifoucsnum;
// "igagnum": "0",
@property (nonatomic, copy) NSString * igagnum;
// "igaunum": "0",
@property (nonatomic, copy) NSString * igaunum;
// "imageUrl": "/upload/userPic/11221299_5.png",
@property (nonatomic, copy) NSString * imageUrl;
// "iopen": 4,
@property (nonatomic, copy) NSString * iopen;
// "iowins": 0,
@property (nonatomic, copy) NSString * iowins;
// "ireturnrate": "0",
@property (nonatomic, copy) NSString * ireturnrate;
// "isfollow": "0",
@property (nonatomic, copy) NSString * isfollow;
// "istate": 2,
@property (nonatomic, copy) NSString * istate;
// "iupload": 1,
@property (nonatomic, copy) NSString * iupload;
// "league": "",
@property (nonatomic, copy) NSString * league;
// "loaddate": "2017-11-02 00:47:08",
@property (nonatomic, copy) NSString * loaddate;
// "lznum": "0",
@property (nonatomic, copy) NSString * lznum;
// "money": 100008,
@property (nonatomic, copy) NSString * money;
// "multiple": 50004,
@property (nonatomic, copy) NSString * multiple;
// "oltpstate": 0,
@property (nonatomic, copy) NSString * oltpstate;
// "pass": "2串1",
@property (nonatomic, copy) NSString * pass;
// "percentage": "0.00",
@property (nonatomic, copy) NSString * percentage;
// "perMoney": "2",
@property (nonatomic, copy) NSString * perMoney;
// "profit": "97",
@property (nonatomic, copy) NSString * profit;
// "projid": "CP70124063800",
@property (nonatomic, copy) NSString * projid;
// "result": "待开奖",
@property (nonatomic, copy) NSString * result;
// "sendPrize": "0",
@property (nonatomic, copy) NSString * sendPrize;
// "silver": "0",
@property (nonatomic, copy) NSString * silver;
// "termNo": "20171102",
@property (nonatomic, copy) NSString * termNo;
// "ticketStatus": "已出票",
@property (nonatomic, copy) NSString * ticketStatus;
// "ticketStatus2": "已出票",
@property (nonatomic, copy) NSString * ticketStatus2;
// "type": "竞彩足球",
@property (nonatomic, copy) NSString * type;
// "uid": "11221299",
@property (nonatomic, copy) NSString * uid;
// "usertitle": "",
@property (nonatomic, copy) NSString * usertitle;
// "winMoney": "0",
@property (nonatomic, copy) NSString * winMoney;
// "zhushu": 1  注数
@property (nonatomic, copy) NSString * zhushu;

@end
