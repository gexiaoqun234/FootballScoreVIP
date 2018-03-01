//
//  TWGetOrdersModel.m
//  105CP
//
//  Created by 田伟 on 2017/11/29.
//  Copyright © 2017年 宋辉. All rights reserved.
//

#import "TWGetOrdersModel.h"

@implementation TWGetOrdersModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"orderDetail":[TWOrderDetailModel class]};
}

@end
