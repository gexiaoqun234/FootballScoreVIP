//
//  TWPhoneFollowDetailModel.m
//  105CP
//
//  Created by 田伟 on 2017/11/6.
//  Copyright © 2017年 宋辉. All rights reserved.
//

#import "TWPhoneFollowDetailModel.h"

@implementation TWPhoneFollowDetailModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"results":@"TWPhoneFollowDetailResultsModel",
             @"result":@"TWPhoneFollowDetailResulltModel",
             @"usertitles":@"TWPhoneFollowDetailUsertitlesModel"
             };
}

@end
