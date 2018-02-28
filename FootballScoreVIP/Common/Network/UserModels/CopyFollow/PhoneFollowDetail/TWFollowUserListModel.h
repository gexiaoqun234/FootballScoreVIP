//
//  TWFollowUserListModel.h
//  105CP
//
//  Created by 田伟 on 2017/11/6.
//  Copyright © 2017年 宋辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TWFollowUserListModel : NSObject
/*
 {
 "canCopyNum": "61",
 "cendtime": "2017-11-05 21:50:00",
 "copysum": "3204",
 "ireturnrate": "1.52",
 
 "isover": "1",
 "iupload": "1",
 "league": "意甲",
 
 "note": "",
 "perMoney": "2",
 "projid": "70_CP70124305575",
 "result": "待开奖",
 
 "type": "竞彩足球",
 "usertitle": "意甲专家",
 "winMoney": "0",
 "zjmoney": "6000"
 }
 */
@property (nonatomic, copy) NSString * canCopyNum;
@property (nonatomic, copy) NSString * cendtime;
@property (nonatomic, copy) NSString * copysum;
@property (nonatomic, copy) NSString * ireturnrate;
@property (nonatomic, copy) NSString * isover;
@property (nonatomic, copy) NSString * iupload;
@property (nonatomic, copy) NSString * league;
@property (nonatomic, copy) NSString * note;
@property (nonatomic, copy) NSString * perMoney;
@property (nonatomic, copy) NSString * projid;
@property (nonatomic, copy) NSString * result;
@property (nonatomic, copy) NSString * type;
@property (nonatomic, copy) NSString * usertitle;
@property (nonatomic, copy) NSString * winMoney;
@property (nonatomic, copy) NSString * zjmoney;

@end
