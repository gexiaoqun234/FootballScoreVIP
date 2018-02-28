//
//  BaseViewController.h
//  FootballScore
//
//  Created by 田伟 on 2018/2/27.
//  Copyright © 2018年 MG. All rights reserved.
//

#import "SHBaseViewController.h"

@interface BaseViewController : SHBaseViewController<DZNEmptyDataSetSource, DZNEmptyDataSetDelegate, UITableViewDelegate, UITableViewDataSource>
// 记录当前空白页的加载状态
@property (nonatomic, getter=isLoading) BOOL loading;
@property (nonatomic, strong) UITableView * tableView;
@end
