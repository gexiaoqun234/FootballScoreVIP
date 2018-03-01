//
//  MySelectForumController.m
//  QQCP30
//
//  Created by 田伟 on 2017/7/24.
//  Copyright © 2017年 魔曦. All rights reserved.
//

#import "MySelectForumController.h"
#import "TWNewsModel.h"
#import "TWNewsCell.h"
#import "TWSelectNewsViewController.h"

@interface MySelectForumController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray <TWNewsModel *> * newsCollectArr;
@property (nonatomic, strong) UIImageView * nojiluImageView;
@property (nonatomic, strong) UITableView * tableView;
@end

@implementation MySelectForumController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"资讯收藏";
     [self.view addSubview:self.tableView];
    [self setupRefresh];
}

- (UIImageView *)nojiluImageView{
    if (!_nojiluImageView) {
        UIImage * nojilu = [UIImage imageNamed:@"tw_NoJiLu"];
        _nojiluImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, nojilu.size.width, nojilu.size.height)];
        _nojiluImageView.center = CGPointMake(TWScreenWidth * 0.5, TWScreenHeight * 0.5 - _nojiluImageView.frame.size.height * 0.5);
        _nojiluImageView.image = nojilu;
    }
    return _nojiluImageView;
}


- (void)initSettingButton{
    UIButton * delectButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [delectButton setImage:[UIImage imageNamed:@"tw_delete"] forState:UIControlStateNormal];
    [delectButton sizeToFit];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:delectButton];
    [[delectButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [self.tableView setEditing:!self.tableView.editing animated:YES];
    }];
}


- (NSMutableArray<TWNewsModel *> *)newsCollectArr{
    if (!_newsCollectArr) {
        _newsCollectArr = [NSMutableArray array];
    }
    return _newsCollectArr;
}

#pragma mark - ========刷新请求数据=======
- (void)setupRefresh{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
}

// 下拉刷新数据
- (void)loadNewData{
    NSArray * array = [[TWFMDBTool sharedDataBase] getOneNewsData];
    [self.newsCollectArr removeAllObjects];
    for (NSInteger i = 0; i < array.count; i++) {
        TWNewsModel * model = array[i][@"newmodel"];
        [self.newsCollectArr addObject:model];
    }
    if (self.newsCollectArr.count == 0) {
        [self.tableView addSubview:self.nojiluImageView];
    } else {
        [self initSettingButton];
        [self.tableView reloadData];
    }
    [self.tableView.mj_header endRefreshing];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.newsCollectArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TWNewsCell * cell = [tableView dequeueReusableCellWithIdentifier:TWNewsCellID forIndexPath:indexPath];
    cell.model = self.newsCollectArr[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TWSelectNewsViewController * newsDetailVc = [[TWSelectNewsViewController alloc]init];
    newsDetailVc.model = self.newsCollectArr[indexPath.row];
    [self.navigationController pushViewController:newsDetailVc animated:YES];
}


#pragma mark --------对cell进行编辑--------
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

#pragma mark - 单选删除及新增元素相关的方法
// 修改Delete按钮文字为“删除”
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // 删除数据库的一条数据
        BOOL success = [[TWFMDBTool sharedDataBase] deleteOneNewsDataWithTitle:self.newsCollectArr[indexPath.row].title];
        
        // 删除数组的数据
        [self.newsCollectArr removeObject:self.newsCollectArr[indexPath.row]];
        
        // 刷新
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
        if (success) {
            [SVProgressHUD showSuccessWithStatus:@"删除成功~"];
            [SVProgressHUD dismissWithDelay:0.5];
        } else {
            [SVProgressHUD showErrorWithStatus:@"删除失败~"];
            [SVProgressHUD dismissWithDelay:0.5];
        }
    }
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
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, TWTabbarHeight, 0);
        [_tableView registerNib:[UINib nibWithNibName:@"TWNewsCell" bundle:nil] forCellReuseIdentifier:TWNewsCellID];
    }
    return _tableView;
}

@end
