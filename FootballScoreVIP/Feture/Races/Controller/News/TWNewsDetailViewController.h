//
//  TWNewsDetailViewController.h
//  105CP
//
//  Created by 田伟 on 2017/11/7.
//  Copyright © 2017年 宋辉. All rights reserved.
//

#import "SHBaseViewController.h"
@class TWNewsModel;

@interface TWNewsDetailViewController : SHBaseViewController
@property (nonatomic, strong) TWNewsModel * model;
@property (nonatomic, copy) NSString * subTitle;
@end
