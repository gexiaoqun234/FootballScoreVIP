//
//  TWPFDetailOneCell.m
//  105CP
//
//  Created by 田伟 on 2017/11/6.
//  Copyright © 2017年 宋辉. All rights reserved.
//

#import "TWPFDetailOneCell.h"
#import "TWPhoneFollowDetailModel.h"

@implementation TWPFDetailOneCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _iconImageView.layer.cornerRadius = 30;
    _iconImageView.layer.masksToBounds = YES;
}

- (void)setModel:(TWPhoneFollowDetailModel *)model{
    _model = model;
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",InterfaceHeader,model.imageUrl]] placeholderImage:[UIImage imageNamed:@"HeadSculpture"]];
    _nicknameLabel.text = model.cnickname;
    
    // 累计中奖
    _icopyawardLabel.attributedText = [self detailcopyaward:model.icopyaward];
    
    // 连中
    if ([model.fsum isEqualToString:@"0"]) {
        _ihitnumLabel.text = [NSString stringWithFormat:@"%@连中",model.ihitnum];
    } else {
        _ihitnumLabel.text = @"";
    }
    
    // 粉丝
    if (model.ifoucsnum) {
        _ifoucsnumLabel.text = [NSString stringWithFormat:@"粉丝：%@",model.ifoucsnum];
    } else {
        _ifoucsnumLabel.text = @"";
    }
   
}

// 处理奖金
- (NSMutableAttributedString *)detailcopyaward:(NSString * )icopyaward{
    NSMutableAttributedString * attrString = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"累计中奖：%@元",icopyaward]];
    NSUInteger len = attrString.length - 1 - 5;
    NSRange range = NSMakeRange(5, len);
    [attrString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
    return attrString;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
