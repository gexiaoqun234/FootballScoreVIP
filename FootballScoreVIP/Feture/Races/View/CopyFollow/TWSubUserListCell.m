//
//  TWSubUserListCell.m
//  105CP
//
//  Created by 田伟 on 2017/11/3.
//  Copyright © 2017年 宋辉. All rights reserved.
//

#import "TWSubUserListCell.h"
#import "TWUserModel.h"

@implementation TWSubUserListCell

- (void)setModel:(TWUserModel *)model{
    _model = model;
    _nicknameLabel.text = model.nickname;
    _cimoneyLabel.text = model.cimoney;
    _cadddateLabel.text = model.cadddate;
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
