//
//  TWPhonefollowDetailVC.m
//  105CP
//
//  Created by 田伟 on 2017/11/6.
//  Copyright © 2017年 宋辉. All rights reserved.
//

#import "TWPhonefollowDetailVC.h"
#import "TWPhoneFollowDetailModel.h"
#import "TWPFDetailOneCell.h"
#import "TWPFDetailTwoCell.h"
#import "TWFollowUserListModel.h"
#import "TWPFDetailListCell.h"
#import "TWPFDLDetailVC.h"

static NSString * const TWPFDetailOneCellID = @"TWPFDetailOneCell";
static NSString * const TWPFDetailTwoCellID = @"TWPFDetailTwoCell";
static NSString * const TWPFDetailListCellID = @"TWPFDetailListCell";
static NSString * const TWauthor = @"author";
static NSString * const TWpage = @"page";
static NSString * const TWpassword = @"password";
static NSString * const TWuser = @"user";
static NSString * const TWversion = @"version";

@interface TWPhonefollowDetailVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) TWPhoneFollowDetailModel * detailModel;
@property (nonatomic, strong) NSMutableArray <TWFollowUserListModel *> * userListArray;
@property (nonatomic, assign) BOOL showSectionOne;
@end

@implementation TWPhonefollowDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [SVProgressHUD show];
    self.title = self.tw_title;
    _showSectionOne = NO;
    [self setupRefresh];
}

#pragma mark - ========tableView懒加载=======
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;

        _tableView.backgroundColor = TWColorRGB(242, 242, 242);
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.scrollIndicatorInsets = _tableView.contentInset;
        [self.view addSubview:_tableView];
        self.extendedLayoutIncludesOpaqueBars = YES;
        if (@available(iOS 11.0, *)) {
            self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        _tableView.contentInset = UIEdgeInsetsMake(TWNaviHeight, 0, 0, 0);
        [_tableView registerNib:[UINib nibWithNibName:@"TWPFDetailOneCell" bundle:nil] forCellReuseIdentifier:TWPFDetailOneCellID];
        [_tableView registerNib:[UINib nibWithNibName:@"TWPFDetailTwoCell" bundle:nil] forCellReuseIdentifier:TWPFDetailTwoCellID];
        [_tableView registerNib:[UINib nibWithNibName:@"TWPFDetailListCell" bundle:nil] forCellReuseIdentifier:TWPFDetailListCellID];
    }
    return _tableView;
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
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, queue, ^{
        NSMutableDictionary * parameters = [NSMutableDictionary dictionary];
        parameters[TWauthor] = self.uid;
        parameters[TWpage] = @(1);
        parameters[TWpassword] = @"";
        parameters[TWuser] = @"";
        parameters[TWversion] = @"20";
        [[SHNetworkTool shareInstance] getDiscoverCopyFollowPhoneFollowDetailDataWith:parameters Success:^(TWPhoneFollowDetailModel *phoneFollowDetailData) {
            _detailModel = phoneFollowDetailData;
            dispatch_semaphore_signal(semaphore);
        } failure:^(NSError *error) {
            dispatch_semaphore_signal(semaphore);
        }];
    });
    
    dispatch_group_async(group, queue, ^{
        NSMutableDictionary * parameters = [NSMutableDictionary dictionary];
        parameters[TWauthor] = self.uid;
        parameters[TWpage] = @(1);
        parameters[TWpassword] = @"";
        parameters[TWuser] = @"";
        parameters[TWversion] = @"20";
        [[SHNetworkTool shareInstance] getDiscoverCopyFollowPhoneFollowDetailListDataWith:parameters Success:^(NSArray *phoneFollowDetailListData) {
            _userListArray = [NSMutableArray arrayWithArray:phoneFollowDetailListData];
            dispatch_semaphore_signal(semaphore);
        } failure:^(NSError *error) {
            dispatch_semaphore_signal(semaphore);
        }];
    });
    
    dispatch_group_notify(group, queue, ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        _showSectionOne = YES;
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        [SVProgressHUD dismiss];
    });
}

// 上拉加载更多
- (void)loadMoreData{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    });
}

#pragma mark - ========tableView代理=======
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (_showSectionOne) {
        return 3;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 2) {
        return _userListArray.count;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 100;
    } else if (indexPath.section == 1) {
        return 250;
    }
    return 125;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        TWPFDetailOneCell * cell = [tableView dequeueReusableCellWithIdentifier:TWPFDetailOneCellID forIndexPath:indexPath];
        cell.model = _detailModel;
        return cell;
    } else if (indexPath.section == 1) {
        TWPFDetailTwoCell * cell = [tableView dequeueReusableCellWithIdentifier:TWPFDetailTwoCellID forIndexPath:indexPath];
        cell.model = _detailModel;
        return cell;
    } else {
        TWPFDetailListCell * cell = [tableView dequeueReusableCellWithIdentifier:TWPFDetailListCellID forIndexPath:indexPath];
        cell.model = _userListArray[indexPath.row];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2) {
        TWPFDLDetailVC * listDetail = [[TWPFDLDetailVC alloc]init];
        listDetail.model = _userListArray[indexPath.row];
        [self.navigationController pushViewController:listDetail animated:YES];
    }
}

// 设置组间距
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.1;
    }
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
