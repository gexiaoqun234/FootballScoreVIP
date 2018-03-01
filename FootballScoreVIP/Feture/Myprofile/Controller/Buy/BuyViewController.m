//
//  BuyViewController.m
//  QQCP30
//
//  Created by 田伟 on 2017/7/24.
//  Copyright © 2017年 魔曦. All rights reserved.
//  中奖记录页面

#import "BuyViewController.h"

@interface BuyViewController ()
@property (nonatomic, strong) UIImageView * nojiluImageView;
@end

@implementation BuyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"中奖记录";
    [self.view addSubview:self.nojiluImageView];
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

@end
