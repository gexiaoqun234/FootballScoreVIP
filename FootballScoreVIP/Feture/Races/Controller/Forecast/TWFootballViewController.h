//
//  TWFootballViewController.h
//  105CP
//
//  Created by 田伟 on 2017/11/7.
//  Copyright © 2017年 宋辉. All rights reserved.
//

#import "SHBaseViewController.h"
@class TWForecastModel;

@interface TWFootballViewController : SHBaseViewController<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray <TWForecastModel *> * dataArray;
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, copy) NSString * subTitle;
- (void)loadNewData;
@end
