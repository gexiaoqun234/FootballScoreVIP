//
//  SHRedUserCollectionCell.m
//  105CP
//
//  Created by 田伟 on 2017/11/1.
//  Copyright © 2017年 宋辉. All rights reserved.
//

#import "SHRedUserCollectionCell.h"
#import "SHRedUserModel.h"

@implementation SHRedUserCollectionCell

- (void)setModel:(SHRedUserModel *)model{
    _model = model;
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",InterfaceHeader,model.imageUrl]] placeholderImage:[UIImage imageNamed:@"HeadSculpture"]];
    _userNameLabel.text = model.nickname;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _iconImageView.layer.cornerRadius = (RedUserCollectionCellWeight - 20) / 2;
    _iconImageView.layer.masksToBounds = YES;
}

@end
