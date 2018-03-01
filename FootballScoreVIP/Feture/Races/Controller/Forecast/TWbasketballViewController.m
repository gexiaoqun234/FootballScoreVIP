//
//  TWbasketballViewController.m
//  105CP
//
//  Created by 田伟 on 2017/11/7.
//  Copyright © 2017年 宋辉. All rights reserved.
//

#import "TWbasketballViewController.h"

@interface TWbasketballViewController ()

@end

@implementation TWbasketballViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (NSString *)subTitle{
    return @"篮球推荐";
}

- (void)loadNewData{
    [[SHNetworkTool shareInstance] getDiscoverForecastDataWithURL:DiscoverCopyFollowjclqURL Success:^(NSArray *forecastArray) {
        self.dataArray = [NSMutableArray arrayWithArray:forecastArray];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
