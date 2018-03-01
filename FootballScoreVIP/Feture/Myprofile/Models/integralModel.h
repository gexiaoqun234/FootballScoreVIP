//
//  integralModel.h
//  QQCP30
//
//  Created by 田伟 on 2017/7/24.
//  Copyright © 2017年 魔曦. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface integralModel : NSObject

// 积分类型名
@property (nonatomic,copy) NSString * name;
// 生成积分明细的时间
@property (nonatomic,copy) NSString * createTime;
// 明细积分数
@property (nonatomic,copy) NSString * score;
// 正负号标识位(0:加积分，1：减积分)
@property (nonatomic,copy) NSString * mark;

@end
