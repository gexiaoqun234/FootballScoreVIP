//
//  SHCelebrityDetailModel.h
//  105CP
//
//  Created by 田伟 on 2017/11/13.
//  Copyright © 2017年 宋辉. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SHCelebrityDetailExplanlistsModel;

@interface SHCelebrityDetailModel : NSObject

@property (nonatomic, copy) NSString * allnum;
@property (nonatomic, copy) NSString * authadvantage;
@property (nonatomic, copy) NSString * authdescription;
@property (nonatomic, copy) NSString * authheadImlUrl;
@property (nonatomic, copy) NSString * authName;
@property (nonatomic, copy) NSString * authTag;
@property (nonatomic, copy) NSString * autrecord;
@property (nonatomic, copy) NSArray <SHCelebrityDetailExplanlistsModel *>* explanlists;
@property (nonatomic, copy) NSString * hitnum;
@property (nonatomic, copy) NSString * jtype;
@property (nonatomic, copy) NSString * lznum;

// 根据获取的authdescription的字符串计算头部视图的高度
@property (nonatomic, assign) CGFloat headerViewHeight;

@end
