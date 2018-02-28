//
//  SHCelebrityDatailViewController.m
//  105CP
//
//  Created by 田伟 on 2017/11/9.
//  Copyright © 2017年 宋辉. All rights reserved.
//

#import "SHCelebrityDatailViewController.h"
#import "TWFamousListsModel.h"
#import "SHCelebrityDetailModel.h"
#import "TWCelebrityDetailHeader.h"
#import "SHCelebrityDetailExplanlistsModel.h"
#import "TWCelebrityDetailCell.h"
#import "SHExplanationDetailViewController.h"

static NSString * const TWCelebrityDetailCellID = @"TWCelebrityDetailCell";

@interface SHCelebrityDatailViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) TWCelebrityDetailHeader * headerView;
@property (nonatomic, strong) SHCelebrityDetailModel * totalModel;
@property (nonatomic, strong) NSMutableArray <SHCelebrityDetailExplanlistsModel *> * modelArray;
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, copy) NSString * typeID;

// 计算headerView的高度
@property (nonatomic, assign) CGFloat headerViewHeight;

// 计算tableView的Y坐标
@property (nonatomic, assign) CGFloat tableViewY;
@end

@implementation SHCelebrityDatailViewController


#pragma mark - ========懒加载=======
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, _tableViewY, TWScreenWidth, TWScreenHeight - _tableViewY) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
//        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.backgroundColor = TWColorRGB(242, 242, 242);
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.scrollIndicatorInsets = _tableView.contentInset;
        [self.view addSubview:_tableView];
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, TWTabbarHeight, 0);
        [_tableView registerNib:[UINib nibWithNibName:@"TWCelebrityDetailCell" bundle:nil] forCellReuseIdentifier:TWCelebrityDetailCellID];
    }
    return _tableView;
}

- (TWCelebrityDetailHeader *)headerView{
    if (!_headerView) {
        _headerView = [TWCelebrityDetailHeader cgreateTWCelebrityDetailHeader];
        _headerView.frame = CGRectMake(0, 0, TWScreenWidth, _headerViewHeight);
        [self.view addSubview:_headerView];
        [_headerView.segmentedControlSingal subscribeNext:^(UISegmentedControl *  _Nullable x) {
            if ([self.tableView.mj_header isRefreshing]) {
                // 如果正在刷新，先暂停刷新，延迟一秒后再重新刷新
                [self.tableView.mj_header endRefreshing];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    _typeID = [NSString stringWithFormat:@"%ld",x.selectedSegmentIndex + 1];
                    [self setupRefresh];
                });
            } else {
                _typeID = [NSString stringWithFormat:@"%ld",x.selectedSegmentIndex + 1];
                [self setupRefresh];
            }
        }];
    }
    return _headerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [SVProgressHUD show];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"名家详情";
    _typeID = @"1";
    [self loadNewData];
}

#pragma mark - ========刷新请求数据=======
- (void)setupRefresh{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}

// 下拉刷新数据
- (void)loadNewData{
    NSMutableDictionary * parameters = [NSMutableDictionary dictionary];
    parameters[@"cfrom"] = @"ios";
    parameters[@"channel"] = @"tzhongcp";
    parameters[@"type"] = _typeID;
    parameters[@"version"] = @"1";
    parameters[@"name"] = self.authNameString;
    
    [[SHNetworkTool shareInstance] getDiscoverCopyFollowsCelebrityDetailWith:parameters Success:^(SHCelebrityDetailModel *celebrityDetailModel) {
        // 拿到总模型
        _totalModel = celebrityDetailModel;
        _modelArray = [NSMutableArray arrayWithArray:celebrityDetailModel.explanlists];
        
        // 设置头部
        _headerViewHeight = _totalModel.headerViewHeight;
        if (_headerViewHeight != 170) {
            self.headerView.tw_height = _headerViewHeight;
            self.headerView.model = _totalModel;
        }
        
        // 设置下面
        _tableViewY = self.headerView.tw_height;
        _tableView.tw_y = _tableViewY;
        _tableView.tw_height = TWScreenHeight - _tableViewY;
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        [SVProgressHUD dismiss];
    } failure:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [SVProgressHUD dismiss];
    }];
}


- (void)loadMoreData{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    });
}

#pragma mark - ========tableView代理=======
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    self.tableView.mj_footer.hidden = _modelArray.count == 0;
    return _modelArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TWCelebrityDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:TWCelebrityDetailCellID forIndexPath:indexPath];
    cell.model = _modelArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SHExplanationDetailViewController * explanationDetailViewController = [[SHExplanationDetailViewController alloc]init];
    // 传值
    explanationDetailViewController.dbnoString = _modelArray[indexPath.row].dbno;
    [self.navigationController pushViewController:explanationDetailViewController animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
