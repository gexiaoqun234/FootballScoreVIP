//
//  TWSelectNewsViewController.m
//  105CP
//
//  Created by 田伟 on 2017/11/17.
//  Copyright © 2017年 宋辉. All rights reserved.
//

#import "TWSelectNewsViewController.h"
#import "TWNewsModel.h"

@interface TWSelectNewsViewController ()<UIWebViewDelegate>
@property (nonatomic, strong) UIWebView * webView;
@end

@implementation TWSelectNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.model.title;
    [SVProgressHUD show];
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, TWScreenWidth, TWScreenHeight - (TWTabbarHeight))];
    NSURL * url = [[NSURL alloc]initWithString:self.model.url];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    _webView.delegate = self;
    [_webView loadRequest:request];
    _webView.scrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_webView];
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
