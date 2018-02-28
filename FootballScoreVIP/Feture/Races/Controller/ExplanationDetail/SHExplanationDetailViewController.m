//
//  SHExplanationDetailViewController.m
//  105CP
//
//  Created by 田伟 on 2017/11/9.
//  Copyright © 2017年 宋辉. All rights reserved.
//

#import "SHExplanationDetailViewController.h"
#import "TWExplainListModel.h"
#import "TWExplanationDetailModel.h"
#import "TWExplanationDetailSectionOne.h"
#import "TWExplanationDetailSectionTwo.h"

static NSString * const TWExplanationDetailSectionOneID = @"TWExplanationDetailSectionOne";
static NSString * const TWExplanationDetailSectionTwoID = @"TWExplanationDetailSectionTwo";

@interface SHExplanationDetailViewController ()<UITableViewDelegate, UITableViewDataSource, UIWebViewDelegate>
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) TWExplanationDetailModel * currentModel;
@property (nonatomic, strong) UIWebView * webView;
@end

@implementation SHExplanationDetailViewController

#pragma mark - ========tableView懒加载=======
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
//        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.backgroundColor = TWColorRGB(242, 242, 242);
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.scrollIndicatorInsets = _tableView.contentInset;
        [self.view addSubview:_tableView];
        // 适配ios11
        self.extendedLayoutIncludesOpaqueBars = YES;// 默认情况下, 扩展布局不包含导航栏
        if (@available(iOS 11.0, *)) {
            self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        [_tableView registerNib:[UINib nibWithNibName:@"TWExplanationDetailSectionOne" bundle:nil] forCellReuseIdentifier:TWExplanationDetailSectionOneID];
        [_tableView registerNib:[UINib nibWithNibName:@"TWExplanationDetailSectionTwo" bundle:nil] forCellReuseIdentifier:TWExplanationDetailSectionTwoID];
        _tableView.tableFooterView = self.webView;
    }
    return _tableView;
}

- (UIWebView *)webView{
    if (!_webView) {
        _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, TWScreenWidth, 0)];
        _webView.delegate = self;
        _webView.scrollView.scrollEnabled = NO;
        _webView.scrollView.backgroundColor = [UIColor whiteColor];
    }
    return _webView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [SVProgressHUD show];
    self.title = @"解说详情";
    [self loadNewData];
}

#pragma mark - ========刷新请求数据=======
// 加载数据
- (void)loadNewData{
    NSMutableDictionary * parameters = [NSMutableDictionary dictionary];
    parameters[@"cfrom"] = @"ios";
    parameters[@"channel"] = @"tzhongcp";
    parameters[@"planNo"] = self.dbnoString;
    parameters[@"version"] = @"1";
    [[SHNetworkTool shareInstance] getCelebrityExplanationDetailDataWith:parameters Success:^(TWExplanationDetailModel *explanationDetailModel) {
        _currentModel = explanationDetailModel;
        NSString * htmlStr = [NSString stringWithFormat:@"<style>img{max-width:%f%;}</style>%@",TWScreenWidth * 0.95,explanationDetailModel.plandescription];
        [self.webView loadHTMLString:htmlStr baseURL:nil];
//        [self.webView loadHTMLString:explanationDetailModel.plandescription baseURL:nil];
        [self.tableView reloadData];
        [SVProgressHUD dismiss];
    } failure:^(NSError *error) {
    }];
}

#pragma mark - ========webView代理=======
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    CGRect frame = webView.frame;
    frame.size.height = 1;
    webView.frame = frame;
    
    frame = webView.frame;
    frame.size = [webView sizeThatFits:CGSizeZero];
    
    frame.size.width = TWScreenWidth;
    frame.size.height += 50;
    
    webView.frame = frame;
    [self.tableView reloadData];
}

#pragma mark - ========tableView代理=======
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        TWExplanationDetailSectionOne * cell = [tableView dequeueReusableCellWithIdentifier:TWExplanationDetailSectionOneID forIndexPath:indexPath];
        cell.model = _currentModel;
        return cell;
    } else {
        TWExplanationDetailSectionTwo * cell = [tableView dequeueReusableCellWithIdentifier:TWExplanationDetailSectionTwoID forIndexPath:indexPath];
        cell.model = _currentModel;
        return cell;
    }
}

// 估算高度
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 10;
    } else if (indexPath.section == 1) {
        return 70;
    }
    return 70;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return UITableViewAutomaticDimension;
    } else {
        return TWPlanforecastitemHeight * _currentModel.planforecastitems.count + 5 * (_currentModel.planforecastitems.count - 1);
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


// 设置表头表尾
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.1;
    } else {
        return 0.01;
    }
}

// 设置footerView
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
