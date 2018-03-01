//
//  IntegralViewController.m
//  QQCP30
//
//  Created by 田伟 on 2017/7/24.
//  Copyright © 2017年 魔曦. All rights reserved.
//

#import "IntegralViewController.h"
#import "integralModel.h"
#import "IntegralCell.h"

@interface IntegralViewController ()
@property (nonatomic,strong) NSMutableArray * integralArr;
@end

@implementation IntegralViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"积分明细";
    self.tableView.backgroundColor = TWColorRGB(242, 242, 242);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"IntegralCell" bundle:nil] forCellReuseIdentifier:IntegralCellID];
    [self setupRefresh];
}

- (void)setupRefresh{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadData];
    }];
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        });
    }];
}

- (void)loadData{
    AccountModel * model = [[AccountTool sharedAccountTool] readAccount];
    NSMutableDictionary * parameters = [NSMutableDictionary dictionary];
    [parameters setObject:model.userId forKey:TWUserID];

    [[TWLoginNetworkTool shareInstance] requsetMethodType:LoginPOST urlString:TWShowScoreDetailUrl parameters:parameters success:^(id responseObject) {
        if ([responseObject[@"errorcode"] isEqualToString:@"0"]) {
            NSArray * array = [integralModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
            _integralArr = [NSMutableArray arrayWithArray:array];
            [self.tableView reloadData];
        } else {
            [SVProgressHUD showErrorWithStatus:responseObject[@"message"]];
        }
        [self.tableView.mj_header endRefreshing];
        
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"获取积分失败，稍后再试~"];
        [self.tableView.mj_header endRefreshing];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    self.tableView.mj_footer.hidden = _integralArr.count == 0 ? YES : NO;
    return _integralArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    IntegralCell * cell = [tableView dequeueReusableCellWithIdentifier:IntegralCellID forIndexPath:indexPath];
    cell.model = _integralArr[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 105;
}



@end
