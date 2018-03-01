//
//  TWNewsDetailViewController.m
//  105CP
//
//  Created by 田伟 on 2017/11/7.
//  Copyright © 2017年 宋辉. All rights reserved.
//

#import "TWNewsDetailViewController.h"
#import "TWNewsModel.h"

@interface TWNewsDetailViewController ()<UIWebViewDelegate>
@property (nonatomic, strong) UIWebView * webView;
@property (nonatomic, strong) UIButton * collectButton;
@property (nonatomic, assign) BOOL isCollect;
@end

@implementation TWNewsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.subTitle;
    [SVProgressHUD show];
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, TWScreenWidth, TWScreenHeight - (TWTabbarHeight))];
    NSURL * url = [[NSURL alloc]initWithString:self.model.url];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    _webView.delegate = self;
    [_webView loadRequest:request];
    _webView.scrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_webView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self createCollectButton];
}

- (UIButton *)collectButton{
    if (!_collectButton) {
        _collectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_collectButton setImage:[UIImage imageNamed:@"uncollect"] forState:UIControlStateNormal];
        [_collectButton sizeToFit];
        [_collectButton addTarget:self action:@selector(collectionButtonClick) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:_collectButton];
    }
    return _collectButton;
}

// 2点击事件
- (void)collectionButtonClick{
    if ([[AccountTool sharedAccountTool] isLogin]) {
        
        if (_isCollect) {
            // 如果已经保存过，就不再保存重设按钮的图标，并提示用户
            [SVProgressHUD showErrorWithStatus:@"已经保存过~"];
        } else {
            // 如果没有保存过，那么就调用工具类，将他保存到本地
            BOOL isSuccess = [[TWFMDBTool sharedDataBase] addOnenewsDataWithNewsModel:self.model];
            if (isSuccess) {
                
                // 不需要重复保存
                _isCollect = YES;
                
                [_collectButton setImage:[UIImage imageNamed:@"collect"] forState:UIControlStateNormal];
                [SVProgressHUD showSuccessWithStatus:@"保存成功~"];
            
            } else {
                [SVProgressHUD showSuccessWithStatus:@"保存失败~"];
            }
        }
        [SVProgressHUD dismissWithDelay:0.5];
        
    } else {
        LoginViewController * login = [[LoginViewController alloc]init];
        [self presentViewController:login animated:YES completion:nil];
    }
}

- (void)createCollectButton{
    
    // 1检查显示状态
    NSArray <NSDictionary *> * saveArray = [[TWFMDBTool sharedDataBase] getOneNewsData];
    NSMutableArray * titleArray = [[NSMutableArray alloc]init];
    for (NSDictionary * dic in saveArray) {
        // 取出所有的title
        [titleArray addObject:dic[@"title"]];
    }
    
    if ([titleArray containsObject:self.model.title]) {
        _isCollect = YES;
        // 如果已经保存过，就不再保存重设按钮的图标，并提示用户
        [self.collectButton setImage:[UIImage imageNamed:@"collect"] forState:UIControlStateNormal];
    } else {
        _isCollect = NO;
        [self.collectButton setImage:[UIImage imageNamed:@"uncollect"] forState:UIControlStateNormal];
    }
}


- (void)webViewDidStartLoad:(UIWebView *)webView{
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [SVProgressHUD dismiss];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [SVProgressHUD showErrorWithStatus:@"网页加载错误，请稍后再试~"];
    [SVProgressHUD dismissWithDelay:1.5 completion:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
