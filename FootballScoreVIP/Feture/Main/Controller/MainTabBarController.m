//
//  MainTabBarController.m
//  105CP
//
//  Created by 宋辉 on 2017/10/31.
//  Copyright © 2017年 宋辉. All rights reserved.
//

#import "MainTabBarController.h"
#import "MainNavigationController.h"
#import "UIImage+Image.h"

#import "DiscoveryViewController.h"
#import "MyprofileViewController.h"
#import "RacesViewController.h"
#import "ScheduleViewController.h"


@interface MainTabBarController ()
@property (nonatomic, strong) DiscoveryViewController * discoverVC;
@property (nonatomic, strong) MyprofileViewController * myprofileVC;
@property (nonatomic, strong) RacesViewController * racesVC;
@property (nonatomic, strong) ScheduleViewController * scheduleVC;
@end

@implementation MainTabBarController

+ (void)load{
    UITabBarItem * item = [UITabBarItem appearanceWhenContainedInInstancesOfClasses:@[self]];

    NSMutableDictionary * dictNomal = [NSMutableDictionary dictionary];
    dictNomal[NSForegroundColorAttributeName] = TWColorRGB(172, 172, 173);

    dictNomal[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    [item setTitleTextAttributes:dictNomal forState:UIControlStateNormal];

    NSMutableDictionary * dictselect = [NSMutableDictionary dictionary];
    dictselect[NSForegroundColorAttributeName] = TWThemeColor;
    [item setTitleTextAttributes:dictselect forState:UIControlStateSelected];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setViewControllers:@[[self addChildViewController:self.racesVC title:@"主页" imageName:@"toolbar_races_normal_26x26_" selectedImageName:@"toolbar_races_activity_26x26_"],
                               [self addChildViewController:self.scheduleVC title:@"解说" imageName:@"toolbar_datas_normal_26x26_" selectedImageName:@"toolbar_datas_activity_26x26_"],
                               [self addChildViewController:self.discoverVC title:@"直播" imageName:@"toolbar_discovery_normal_26x26_" selectedImageName:@"toolbar_discovery_activity_26x26_"],
                               [self addChildViewController:self.myprofileVC title:@"我的" imageName:@"toolbar_myprofile_normal_26x26_" selectedImageName:@"toolbar_myprofile_activity_26x26_"]
                               ]
     ];
}

- (UIViewController *)addChildViewController:(UIViewController *)childController title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName {
    childController.title = title;
    childController.tabBarItem.image = [UIImage imageOriginalWithName:imageName];
    childController.tabBarItem.selectedImage = [UIImage imageOriginalWithName:selectedImageName];
    MainNavigationController * nav = [[MainNavigationController alloc]initWithRootViewController:childController];
    [self addChildViewController:nav];
    return nav;
}

- (RacesViewController *)racesVC{
    if (_racesVC == nil) {
        _racesVC = [[RacesViewController alloc]init];
    }
    return _racesVC;
}

- (ScheduleViewController *)scheduleVC{
    if (_scheduleVC == nil) {
        _scheduleVC = [[ScheduleViewController alloc]init];
    }
    return _scheduleVC;
}

- (DiscoveryViewController *)discoverVC{
    if (_discoverVC == nil) {
        _discoverVC = [[DiscoveryViewController alloc]init];
    }
    return _discoverVC;
}

- (MyprofileViewController *)myprofileVC{
    if (_myprofileVC == nil) {
        _myprofileVC = [[MyprofileViewController alloc]init];
    }
    return _myprofileVC;
}

@end
