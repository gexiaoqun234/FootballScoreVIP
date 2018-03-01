//
//  TWTime.h
//  105CP
//
//  Created by 田伟 on 2017/12/6.
//  Copyright © 2017年 宋辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TWTime : NSObject

+ (BOOL)isSameDay:(NSDate*)date1 date2:(NSDate*)date2;

+ (BOOL)isSameMinute:(NSDate*)date1 date2:(NSDate*)date2;

@end
