//
//  TWNewsCell.m
//  105CP
//
//  Created by 田伟 on 2017/11/7.
//  Copyright © 2017年 宋辉. All rights reserved.
//

#import "TWNewsCell.h"
#import "TWNewsModel.h"

@implementation TWNewsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(TWNewsModel *)model{
    _model = model;
    [_imageImageView sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"tw_rec_explain_team_icon"]];
    _tw_titleLabel.text = model.title;
    _pubdateLabel.text = model.pubdate;
    _contentsLabel.text = model.contents;
}

//- (void)setFrame:(CGRect)frame{
//    frame.size.height -= 2;
//    [super setFrame:frame];
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
