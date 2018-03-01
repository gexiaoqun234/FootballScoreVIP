//
//  SaveSelectorModel.h
//  LotteryAssistant
//
//  Created by 田伟 on 2017/5/25.
//  Copyright © 2017年 个人. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SaveSelectorModel : NSObject<NSCoding>

@property (nonatomic,strong) NSArray * redArr;
@property (nonatomic,strong) NSArray * blueArr;

@property (nonatomic,copy) NSString * time;
@property (nonatomic,copy) NSString * type;

@end
