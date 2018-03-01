//
//  TWForecastDetailViewController.h
//  105CP
//
//  Created by 田伟 on 2017/11/7.
//  Copyright © 2017年 宋辉. All rights reserved.
//

#import "SHBaseViewController.h"
@class TWForecastModel;

@interface TWForecastDetailViewController : SHBaseViewController
@property (nonatomic, strong) TWForecastModel * model;
@property (nonatomic, copy) NSString * subTitle;
@end
