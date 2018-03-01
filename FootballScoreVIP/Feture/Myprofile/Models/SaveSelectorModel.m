//
//  SaveSelectorModel.m
//  LotteryAssistant
//
//  Created by 田伟 on 2017/5/25.
//  Copyright © 2017年 个人. All rights reserved.
//

#import "SaveSelectorModel.h"

@implementation SaveSelectorModel

- (instancetype)initWithCoder:(NSCoder *)coder{
    self = [super init];
    if (self) {
        self.time = [coder decodeObjectForKey:@"time"];
        self.type = [coder decodeObjectForKey:@"type"];
        self.redArr = [coder decodeObjectForKey:@"redArr"];
        self.blueArr = [coder decodeObjectForKey:@"blueArr"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.time forKey:@"time"];
    [aCoder encodeObject:self.type forKey:@"type"];
    [aCoder encodeObject:self.redArr forKey:@"redArr"];
    [aCoder encodeObject:self.blueArr forKey:@"blueArr"];
}

//- (NSString *)description{
//    return [NSString stringWithFormat:@"redArr:%@,blueArr:%@,time:%@,type:%@",_redArr,_blueArr,_time,_type];
//}

@end
