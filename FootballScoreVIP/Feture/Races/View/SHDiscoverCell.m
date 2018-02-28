//
//  SHDiscoverCell.m
//  105CP
//
//  Created by 田伟 on 2017/11/1.
//  Copyright © 2017年 宋辉. All rights reserved.
//

#import "SHDiscoverCell.h"
#import "SHDiscoverModel.h"

@implementation SHDiscoverCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(SHDiscoverModel *)model{
    _model = model;
    _iconImageView.image = [UIImage imageNamed:model.imageName];
    _tw_titleLabel.text = model.title;
    _tw_subTitleLable.text = model.subTitle;
}

- (void)setFrame:(CGRect)frame{
    frame.size.height -= 2;
    [super setFrame:frame];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
