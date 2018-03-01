//
//  MineHeaderTopView.m
//  QQCP30
//
//  Created by 田伟 on 2017/7/20.
//  Copyright © 2017年 魔曦. All rights reserved.
//

#import "MineHeaderTopView.h"
#import "AccountModel.h"
#import "UILabel+TWLabel.h"
#import "UIImage+TFImageEffects.h"

@implementation MineHeaderTopView

#define iconWH 80

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (RACSubject *)iconImageViewSingal{
    if (_iconImageViewSingal == nil) {
        _iconImageViewSingal = [RACSubject subject];
    }
    return _iconImageViewSingal;
}

// 初始化
- (void)setupUI{
    _backgroundImageView = [[UIImageView alloc]init];
    _backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    _backgroundImageView.layer.masksToBounds = YES;
    [self addSubview:_backgroundImageView];
    
    _iconImageView = [[UIImageView alloc]init];
    _iconImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    _iconImageView.layer.borderWidth = 2;
    _iconImageView.layer.cornerRadius = iconWH * 0.5;
    _iconImageView.layer.masksToBounds = YES;
    _iconImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(iconImageViewDidClick)];
    [_iconImageView addGestureRecognizer:tap];
    [self addSubview:_iconImageView];
    
    _userNameLabel = [UILabel createLabelWithFrame:CGRectZero text:@"您还未登录" numberOfLines:0 textColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentCenter];
    [self addSubview:_userNameLabel];
    _userSignLabel = [UILabel createLabelWithFrame:CGRectZero text:@"登录后可以设置签名" numberOfLines:0 textColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:12] textAlignment:NSTextAlignmentCenter];
    [self addSubview:_userSignLabel];
}

- (void)iconImageViewDidClick{
    [self.iconImageViewSingal sendNext:@"点击了头像"];
}

// 布局
- (void)layoutSubviews{
    [super layoutSubviews];
    _backgroundImageView.frame = CGRectMake(0, 0, TWScreenWidth, self.frame.size.height);
    _iconImageView.frame = CGRectMake((TWScreenWidth - iconWH) * 0.5, (self.frame.size.height - iconWH) * 0.4, iconWH, iconWH);
    [_userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_iconImageView.mas_bottom).offset(10);
        make.width.centerX.equalTo(self);
    }];
    [_userSignLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_userNameLabel.mas_bottom).offset(10);
        make.width.centerX.equalTo(self);
    }];
}

// 赋值
- (void)setMineModel:(AccountModel *)mineModel{
    _mineModel = mineModel;
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:mineModel.imgPath] placeholderImage:[UIImage imageNamed:@"iconP"]];
    
    // 设置模糊背景
    [_backgroundImageView sd_setImageWithURL:[NSURL URLWithString:mineModel.imgPath] placeholderImage:[UIImage imageNamed:@"mineBg1"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {

        if (image) {
            _backgroundImageView.image = [image applyDarkEffect];
        }
    }];
    
    if (mineModel.username != nil) {
        _userNameLabel.text = mineModel.username;
    }
    if (mineModel.userSign != nil) {
        _userSignLabel.text = mineModel.userSign;
    }
}

@end
