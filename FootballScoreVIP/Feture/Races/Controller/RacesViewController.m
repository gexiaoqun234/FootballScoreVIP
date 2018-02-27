//
//  RacesViewController.m
//  FootballScore
//
//  Created by 田伟 on 2018/2/27.
//  Copyright © 2018年 MG. All rights reserved.
//

#import "RacesViewController.h"

@interface RacesViewController ()

@end

@implementation RacesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
}


- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button{
    [super emptyDataSet:scrollView didTapButton:button];
    
    // 加载数据
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.loading = NO;
    });
}

@end
