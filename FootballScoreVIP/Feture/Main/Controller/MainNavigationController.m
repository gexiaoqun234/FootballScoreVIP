//
//  MainNavigationController.m
//  105CP
//
//  Created by 宋辉 on 2017/10/31.
//  Copyright © 2017年 宋辉. All rights reserved.
//

#import "MainNavigationController.h"

@interface MainNavigationController ()<UINavigationControllerDelegate, UIGestureRecognizerDelegate>

@end

@implementation MainNavigationController

+ (void)initialize{
    UINavigationBar * navBar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[self]];
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    dict[NSFontAttributeName] = [UIFont boldSystemFontOfSize:22];
    dict[NSForegroundColorAttributeName] = [UIColor whiteColor];
    [navBar setTitleTextAttributes:dict];
    // 主色调
    navBar.translucent = NO;    //（去掉类似蒙版层）
    [navBar setBarTintColor:TWThemeColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // iOS7 UINavigationController 右滑popVC的手势.
    self.interactivePopGestureRecognizer.delegate = self;
    self.delegate = self;
}

// 重写push
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.viewControllers.count > 0) {
        // 隐藏tabBar底部
        viewController.hidesBottomBarWhenPushed = YES;
        self.interactivePopGestureRecognizer.enabled = YES;
        //设置统一的返回按钮
        UIButton * backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [backButton setImage:[UIImage imageNamed:@"tw_back"] forState:UIControlStateNormal];
        [backButton sizeToFit];
        [backButton setContentEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
        [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    }

    viewController.view.backgroundColor = [UIColor whiteColor];
    [super pushViewController:viewController animated:animated];
}

- (void)back{
    [self popViewControllerAnimated:YES];
}

// 实现UINavigationControllerDelegate 避免pop到rootVC还能响应手势,一拉就蹦的情况
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.viewControllers.count == 1) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
}

@end
