//
//  RacesViewController.m
//  FootballScore
//
//  Created by 田伟 on 2018/2/27.
//  Copyright © 2018年 MG. All rights reserved.
//

#import "RacesViewController.h"
#import "TWNewsModel.h"
#import "TWFamousListsModel.h"
#import "SHRedUserModel.h"
#import "TWForecastModel.h"


#import "SHMoreCelebrityViewController.h"
#import "SHCelebrityDatailViewController.h"
#import "TWPhonefollowDetailVC.h"
#import "TWForecastDetailViewController.h"
#import "TWNewsDetailViewController.h"
#import "TWNewsViewController.h"
#import "TWForecastViewController.h"

@interface RacesViewController ()
@property (nonatomic, strong) NSMutableArray <TWFamousListsModel *> * famousListArray;
@property (nonatomic, strong) TWFamousListsModel * moreModel;
@property (nonatomic, strong) NSMutableArray <SHRedUserModel *> * redUsersArray;
@property (nonatomic, strong) UIView * redUserHeaderView;
@property (nonatomic, strong) UIView * hotListHeaderView;
@property (nonatomic, strong) NSMutableArray <TWForecastModel *> * forecastArray;
@property (nonatomic, strong) NSArray <TWNewsModel *> * newsModelArray;
@property (nonatomic, assign) BOOL showSectionOne;
@end

@implementation RacesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _showSectionOne = NO;
    [self.view addSubview:self.tableView];
    [self setupRefresh];
    [self configControl];
}

- (void)setupRefresh{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
}

// 下拉刷新数据
- (void)loadNewData{
    
    [SVProgressHUD show];
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group = dispatch_group_create();
    
    // 第一个请求专家名人
    dispatch_group_async(group, queue, ^{
        [[SHNetworkTool shareInstance] getCelebrityExplanationFamousListsDataSuccess:^(NSArray *famousListsArray) {
            _famousListArray = [NSMutableArray arrayWithArray:famousListsArray];
            [_famousListArray addObject:self.moreModel];
            dispatch_semaphore_signal(semaphore);
        } failure:^(NSError *error) {
            dispatch_semaphore_signal(semaphore);
        }];
    });

    // 第二个请求红人版
    dispatch_group_async(group, queue, ^{
        // 处理红人的数据请求
        [[SHNetworkTool shareInstance] getDiscoverCopyFollowRedUserDataSuccess:^(NSArray *redUserArray) {
            _redUsersArray = [NSMutableArray arrayWithArray:redUserArray];
            dispatch_semaphore_signal(semaphore);
        } failure:^(NSError *error) {
            dispatch_semaphore_signal(semaphore);
        }];
    });
    
    // 第三个请求每日竞彩
    dispatch_group_async(group, queue, ^{
        [[SHNetworkTool shareInstance] getDiscoverForecastDataWithURL:DiscoverCopyFollowjczqURL Success:^(NSArray *forecastArray) {
            if (forecastArray.count >= 5) {
                NSMutableArray * tempArray = [NSMutableArray arrayWithCapacity:5];
                for (NSInteger i = 0; i < 5; i++) {
                    [tempArray addObject:forecastArray[i]];
                }
                _forecastArray = [NSMutableArray arrayWithArray:tempArray];
            } else {
                _forecastArray = [NSMutableArray arrayWithArray:forecastArray];
            }
            dispatch_semaphore_signal(semaphore);
        } failure:^(NSError *error) {
            dispatch_semaphore_signal(semaphore);
        }];
    });
    
    // 第四个请求新闻资讯
    dispatch_group_async(group, queue, ^{
        [[SHNetworkTool shareInstance] getDiscoverNewsDataWithURL:DiscoverCopyFollowFootballURL Success:^(NSArray *newsArray) {
            if (newsArray.count >= 5) {
                NSMutableArray * tempArray = [NSMutableArray arrayWithCapacity:5];
                for (NSInteger i = 0; i < 5; i++) {
                    [tempArray addObject:newsArray[i]];
                }
                _newsModelArray = [NSMutableArray arrayWithArray:tempArray];
            } else {
                _newsModelArray = [NSMutableArray arrayWithArray:newsArray];
            }
            dispatch_semaphore_signal(semaphore);
        } failure:^(NSError *error) {
            dispatch_semaphore_signal(semaphore);
        }];
    });
    
    // 四次请求全部完成后再执行这里
    dispatch_group_notify(group, queue, ^{
        // 四个请求对应四次信号等待
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        _showSectionOne = YES;
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        self.loading = NO;
        [SVProgressHUD dismiss];
    });
}

// 增加一个更多model
- (TWFamousListsModel *)moreModel{
    if (!_moreModel) {
        _moreModel = [[TWFamousListsModel alloc]init];
        _moreModel.authName = @"查看更多";
    }
    return _moreModel;
}


#pragma mark - ========代理=======
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    if (_showSectionOne) {
        return 4;
//    } else {
//        return 0;
//    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return 1;
    } else if (section == 2) {
        return _forecastArray.count;
    } else if (section == 3) {
        return _newsModelArray.count;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return FamousListCollectionCellHeight * 2 + 1;
    } else if (indexPath.section == 1) {
        return RedUserCollectionCellHeight * 2 + 1;
    } else if (indexPath.section == 3) {
        return 100;
    } else if (indexPath.section == 2) {
        return 100;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {
        // 1 专家名人
        TWFamousListCell * cell = [tableView dequeueReusableCellWithIdentifier:TWFamousListCellID forIndexPath:indexPath];
        cell.listArray = _famousListArray;
        return cell;
    } else if (indexPath.section == 1) {
        // 2 红人版
        SHSectionTwoCell * cell = [tableView dequeueReusableCellWithIdentifier:CFSectionTwoCell forIndexPath:indexPath];
        cell.backgroundColor = [UIColor whiteColor];
        cell.userArray = _redUsersArray;
        return cell;
    } else if (indexPath.section == 3) {
        // 3 每日竞彩
        TWForecastCell * cell = [tableView dequeueReusableCellWithIdentifier:TWForecastCellID forIndexPath:indexPath];
        cell.model = _forecastArray[indexPath.row];
        return cell;
    } else if (indexPath.section == 2) {
        // 4 新闻资讯
        TWNewsCell * cell = [tableView dequeueReusableCellWithIdentifier:TWNewsCellID forIndexPath:indexPath];
        cell.model = _newsModelArray[indexPath.row];
        return cell;
    }
    return nil;
}

// 设置组间距
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return [self createHeaderView:@"专家名人"];
    } else if (section == 1) {
        return self.redUserHeaderView;
    } else if (section == 3) {
        return self.hotListHeaderView;
    } else if (section == 2) {
        return [self createHeaderView:@"足球新闻资讯"];
    }
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return TableViewSectionHeaderHeight;
    } else if (section == 1) {
        return TableViewSectionHeaderHeight;
    } else if (section == 2) {
        return TableViewSectionHeaderHeight;
    } else if (section == 3) {
        return TableViewSectionHeaderHeight;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 2) {
        return [self createFooterView:@"———— 查看全部资讯 ————" tag:11];
    } else if (section == 3) {
        return [self createFooterView:@"———— 查看更多竞彩 ————" tag:22];
    } else {
        return [UIView new];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 2) {
        return TableViewSectionHeaderHeight + 10;
    } else if (section == 3) {
        return TableViewSectionHeaderHeight + 10;
    } else {
        return 10;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2) {
        TWNewsDetailViewController * detailVc = [[TWNewsDetailViewController alloc]init];
        detailVc.model = _newsModelArray[indexPath.row];
        detailVc.subTitle = @"足球资讯";
        [self.navigationController pushViewController:detailVc animated:YES];
    } else if (indexPath.section == 3) {
        TWForecastDetailViewController * detailVc = [[TWForecastDetailViewController alloc]init];
        detailVc.model = _forecastArray[indexPath.row];
        detailVc.subTitle = @"足球推荐";
        [self.navigationController pushViewController:detailVc animated:YES];
    }
}


// emptyDataSet点击按钮重新加载数据
- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button{
    [super emptyDataSet:scrollView didTapButton:button];
    
    // 加载数据
//    [self setupRefresh];
    [self.tableView.mj_header beginRefreshing];
}

#pragma mark - ========接受通知=======
- (void)configControl{
    // cell1中的点击
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:TWFamousListsDidClickNotification object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        TWFamousListsModel * selectModel = x.object;
        if ([selectModel.authName isEqualToString:@"查看更多"]) {
            // 跳转到展示更多的页面
            SHMoreCelebrityViewController * moreCelebrityViewController = [[SHMoreCelebrityViewController alloc]init];
            moreCelebrityViewController.title = @"名人列表";
            [self.navigationController pushViewController:moreCelebrityViewController animated:YES];
        } else {
            // 跳转到显示详情的页面
            SHCelebrityDatailViewController * celebrityDatailViewController = [[SHCelebrityDatailViewController alloc]init];
            // 传递模型
            celebrityDatailViewController.authNameString = selectModel.authName;
            [self.navigationController pushViewController:celebrityDatailViewController animated:YES];
        }
    }];
    
    // cell2中的点击
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:SHRedUserViewRedUserDidClickNotification object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        SHRedUserModel * selectModel = x.object;
        TWPhonefollowDetailVC * phoneFollowDetailVc = [[TWPhonefollowDetailVC alloc]init];
        phoneFollowDetailVc.uid = selectModel.uid;
        phoneFollowDetailVc.tw_title = selectModel.nickname;
        [self.navigationController pushViewController:phoneFollowDetailVc animated:YES];
    }];
}

#pragma mark - ========懒加载=======
- (UIView *)createHeaderView:(NSString *)title{
    UIView * bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, TWScreenWidth, TableViewSectionHeaderHeight)];
    bgView.backgroundColor = [UIColor whiteColor];
    // title
    UILabel * redLabel = [[UILabel alloc]init];
    redLabel.text = title;
    [redLabel sizeToFit];
    redLabel.textColor = TWThemeColor;
    redLabel.font = [UIFont boldSystemFontOfSize:15];
    [bgView addSubview:redLabel];
    [redLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView).offset(20);
        make.top.bottom.equalTo(bgView);
    }];
    // 底线
    UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(10, TableViewSectionHeaderHeight - 0.5, redLabel.tw_width + 20, 0.5)];
    lineView.backgroundColor = TWThemeColor;
    [bgView addSubview:lineView];
    return bgView;
}

- (UIView *)createFooterView:(NSString *)title tag:(NSInteger)tag{
    UIView * bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, TWScreenWidth, TableViewSectionHeaderHeight + 10)];
    bgView.backgroundColor = [UIColor clearColor];
    
    UIView * topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, TWScreenWidth, TableViewSectionHeaderHeight)];
    topView.backgroundColor = [UIColor whiteColor];
    [bgView addSubview:topView];
    
    // button
    UIButton * showMoreButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [showMoreButton setTitle:title forState:UIControlStateNormal];
    [showMoreButton setTitleColor:TWThemeColor forState:UIControlStateNormal];
    showMoreButton.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [topView addSubview:showMoreButton];
    showMoreButton.tag = tag;
    [showMoreButton addTarget:self action:@selector(showMoreButtonDidClick:) forControlEvents:UIControlEventTouchUpInside];
    [showMoreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(topView);
    }];
    return bgView;
}

- (void)showMoreButtonDidClick:(UIButton *)button{
    if (button.tag == 11) {
        // 足球资讯
        TWNewsViewController * newsVC = [[TWNewsViewController alloc]init];
        [self.navigationController pushViewController:newsVC animated:YES];
    } else if (button.tag == 22) {
        // 足球竞彩
        TWForecastViewController * forecastVC = [[TWForecastViewController alloc]init];
        [self.navigationController pushViewController:forecastVC animated:YES];
    }
}

// 热门跟单标题栏
- (UIView *)hotListHeaderView{
    if (!_hotListHeaderView) {
        _hotListHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, TWScreenWidth, TableViewSectionHeaderHeight)];
        _hotListHeaderView.backgroundColor = [UIColor whiteColor];
        // 每日竞彩
        UILabel * redLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, TWScreenWidth, TableViewSectionHeaderHeight)];
        redLabel.text = @"每日足球竞彩";
        redLabel.backgroundColor = [UIColor whiteColor];
        redLabel.textAlignment = NSTextAlignmentLeft;
        redLabel.textColor = TWThemeColor;
        redLabel.font = [UIFont boldSystemFontOfSize:15];
        [_hotListHeaderView addSubview:redLabel];
        
        // 底线
        UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(0, TableViewSectionHeaderHeight - 0.5, TWScreenWidth, 0.5)];
        lineView.backgroundColor = TWThemeColor;
        [_hotListHeaderView addSubview:lineView];
    }
    return _hotListHeaderView;
}


// 红人标题栏
- (UIView *)redUserHeaderView{
    if (!_redUserHeaderView) {
        _redUserHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, TWScreenWidth, TableViewSectionHeaderHeight)];
        _redUserHeaderView.backgroundColor = [UIColor whiteColor];
        // 红人
        UILabel * redLabel = [[UILabel alloc]init];
        redLabel.text = @"—红人—";
        redLabel.textColor = TWThemeColor;
        redLabel.font = [UIFont boldSystemFontOfSize:15];
        [_redUserHeaderView addSubview:redLabel];
        [redLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_redUserHeaderView).offset(20);
            make.top.bottom.equalTo(_redUserHeaderView);
        }];
        
        // 图片
        UIImageView * redImageView = [[UIImageView alloc]init];
        redImageView.image = [UIImage imageNamed:@"tw_redUsersOfFollowOrder"];
        [_redUserHeaderView addSubview:redImageView];
        [redImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(redLabel);
            make.left.equalTo(redLabel.mas_right).offset(10);
        }];
        
        // 底线
        UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(0, TableViewSectionHeaderHeight - 0.5, TWScreenWidth, 0.5)];
        lineView.backgroundColor = TWThemeColor;
        [_redUserHeaderView addSubview:lineView];
    }
    return _redUserHeaderView;
}


@end
