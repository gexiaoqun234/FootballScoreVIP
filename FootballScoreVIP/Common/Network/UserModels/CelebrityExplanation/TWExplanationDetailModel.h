//
//  TWExplanationDetailModel.h
//  105CP
//
//  Created by 田伟 on 2017/11/9.
//  Copyright © 2017年 宋辉. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SHPlanforecastitemsModel;

@interface TWExplanationDetailModel : NSObject

@property (nonatomic, copy) NSString * allnum;
@property (nonatomic, copy) NSString * authdescription;
@property (nonatomic, copy) NSString * authheadImlUrl;
@property (nonatomic, copy) NSString * authName;
@property (nonatomic, copy) NSString * authTag;
@property (nonatomic, copy) NSString * begintime;
@property (nonatomic, copy) NSString * dbno;
@property (nonatomic, copy) NSString * endtime;
@property (nonatomic, copy) NSString * hitnum;
@property (nonatomic, copy) NSString * isbuy;
@property (nonatomic, copy) NSString * isSee;
@property (nonatomic, copy) NSString * jtype;
@property (nonatomic, copy) NSString * lotterytype;
@property (nonatomic, copy) NSString * lznum;
@property (nonatomic, copy) NSString * plandescription;
@property (nonatomic, copy) NSArray <SHPlanforecastitemsModel *> * planforecastitems;
@property (nonatomic, copy) NSString * plansummary;
@property (nonatomic, copy) NSString * plantitle;
@property (nonatomic, copy) NSString * releaseTime;
@property (nonatomic, copy) NSString * salepeice;
@property (nonatomic, copy) NSString * timeType;

@end
