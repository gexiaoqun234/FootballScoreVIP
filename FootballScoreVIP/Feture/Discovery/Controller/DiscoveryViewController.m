//
//  DiscoveryViewController.m
//  FootballScore
//
//  Created by 田伟 on 2018/2/27.
//  Copyright © 2018年 MG. All rights reserved.
//

#import "DiscoveryViewController.h"

@interface DiscoveryViewController ()<UIWebViewDelegate, UIScrollViewDelegate>
@property (nonatomic,strong) UIWebView * webView;
@property (nonatomic,strong) UIView * backgroundView;
@end

@implementation DiscoveryViewController

#define TWLiveFootballURL @"http://nlive.159cai.com/live"

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 加载网页
    NSURL * url = [NSURL URLWithString:TWLiveFootballURL];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    _webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    _webView.delegate = self;
    _webView.scrollView.delegate = self;
    _webView.scrollView.backgroundColor = [UIColor whiteColor];
    [_webView loadRequest:request];
    [self.view addSubview:_webView];
    [_webView addSubview:self.backgroundView];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [SVProgressHUD showErrorWithStatus:@"网页加载错误，请稍后再试~"];
    [SVProgressHUD dismissWithDelay:1.5 completion:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    return YES;
}


- (UIView *)backgroundView{
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, TWScreenWidth, TWStateHeight)];
        _backgroundView.backgroundColor = TWWebViewStatueColor;
    }
    return _backgroundView;
}



@end
