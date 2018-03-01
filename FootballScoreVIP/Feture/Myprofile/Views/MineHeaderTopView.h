//
//  MineHeaderTopView.h
//  QQCP30
//
//  Created by 田伟 on 2017/7/20.
//  Copyright © 2017年 魔曦. All rights reserved.
//  固定的headerView

#import <UIKit/UIKit.h>
@class AccountModel;

@interface MineHeaderTopView : UIView

@property (nonatomic, strong) AccountModel * mineModel;
@property (nonatomic, strong) UIImageView * backgroundImageView;    // 背景图片
@property (nonatomic, strong) UIImageView * iconImageView;          // 头像
@property (nonatomic, strong) RACSubject * iconImageViewSingal;
@property (nonatomic, strong) UILabel * userNameLabel;              // 用户名
@property (nonatomic, strong) UILabel * userSignLabel;              // 用户签名

@end
