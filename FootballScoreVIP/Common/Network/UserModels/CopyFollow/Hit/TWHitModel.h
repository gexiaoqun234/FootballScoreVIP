//
//  TWHitModel.h
//  105CP
//
//  Created by 田伟 on 2017/11/6.
//  Copyright © 2017年 宋辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TWHitModel : NSObject

/*
 "allnum": "17",
 "canCopyNum": 0,
 "hitcount": "11",
 "hitnum": "11",
 "imageUrl": "/upload/userPic/11268608_8.png",
 "ishot": 1,
 "nickname": "3000x365",
 "uid": "11268608"
 */
@property (nonatomic, copy) NSString * allnum;
@property (nonatomic, copy) NSString * canCopyNum;
@property (nonatomic, copy) NSString * hitcount;
@property (nonatomic, copy) NSString * hitnum;
@property (nonatomic, copy) NSString * imageUrl;
@property (nonatomic, copy) NSString * ishot;
@property (nonatomic, copy) NSString * nickname;
@property (nonatomic, copy) NSString * uid;

@end
