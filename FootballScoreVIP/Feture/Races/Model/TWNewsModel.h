//
//  TWNewsModel.h
//  105CP
//
//  Created by 田伟 on 2017/11/6.
//  Copyright © 2017年 宋辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TWNewsModel : NSObject<NSCoding>

@property (nonatomic, copy) NSString * contents;
@property (nonatomic, copy) NSString * image;
@property (nonatomic, copy) NSString * pubdate;
@property (nonatomic, copy) NSString * title;
@property (nonatomic, copy) NSString * url;

@end
