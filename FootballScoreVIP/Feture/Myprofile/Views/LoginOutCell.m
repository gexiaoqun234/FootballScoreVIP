//
//  LoginOutCell.m
//  QQCP30
//
//  Created by 田伟 on 2017/7/21.
//  Copyright © 2017年 魔曦. All rights reserved.
//

#import "LoginOutCell.h"

@interface LoginOutCell ()
@property (nonatomic, strong)UILabel * loginOut;
@end

@implementation LoginOutCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _loginOut = [[UILabel alloc]initWithFrame:self.frame];
        _loginOut.textColor = [UIColor blackColor];
        _loginOut.font = [UIFont systemFontOfSize:14];
        _loginOut.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_loginOut];
    }
    return self;
}

- (void)setTitle:(NSString *)title{
    _title = title;
    _loginOut.text = title;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
