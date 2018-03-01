//
//  TWNewsBaseBallViewController.m
//  105CP
//
//  Created by 田伟 on 2017/11/7.
//  Copyright © 2017年 宋辉. All rights reserved.
//

#import "TWNewsBaseBallViewController.h"

@interface TWNewsBaseBallViewController ()

@end

@implementation TWNewsBaseBallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

// 下拉刷新数据
- (void)loadNewData{
    [[SHNetworkTool shareInstance] getDiscoverNewsDataWithURL:DiscoverCopyFollowBasketballURL Success:^(NSArray *newsArray) {
        self.dataArray = [NSMutableArray arrayWithArray:newsArray];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
    }];
}

- (NSString *)subTitle{
    return @"篮球资讯";
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
