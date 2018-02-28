//
//  TWProfitUserCell.m
//  105CP
//
//  Created by 田伟 on 2017/11/6.
//  Copyright © 2017年 宋辉. All rights reserved.
//

#import "TWProfitUserCell.h"
#import "TWProfitModel.h"

@implementation TWProfitUserCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _iconImageView.layer.cornerRadius = 25;
    _iconImageView.layer.masksToBounds = YES;
    
    _canCopyNumButton.layer.cornerRadius = 3;
    _canCopyNumButton.layer.masksToBounds = YES;
    
    _serialNumberButton.layer.cornerRadius = 15;
    _serialNumberButton.layer.masksToBounds = YES;
    _serialNumberButton.layer.borderColor = [UIColor redColor].CGColor;
    _serialNumberButton.layer.borderWidth = 1;
    
    _tw_copyNumButton.layer.cornerRadius = 8;
    _tw_copyNumButton.layer.masksToBounds = YES;
    _tw_copyNumButton.layer.borderColor = [UIColor redColor].CGColor;
    _tw_copyNumButton.layer.borderWidth = 1;
}

- (void)setModel:(TWProfitModel *)model{
    _model = model;
    
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",InterfaceHeader,model.imageUrl]] placeholderImage:[UIImage imageNamed:@"HeadSculpture"]];
    _nickNameLabel.text = model.nickname;
    
    _prohitLabel.text = [NSString stringWithFormat:@"%@%%",model.profit];
    
    // 可跟单
    NSInteger num = [model.canCopyNum integerValue];
    if (num == 0) {
        _tw_copyNumButton.hidden = YES;
        [_canCopyNumButton setBackgroundColor:[UIColor darkGrayColor]];
    } else {
        _tw_copyNumButton.hidden = NO;
        [_tw_copyNumButton setTitle:model.canCopyNum forState:UIControlStateNormal];
        [_canCopyNumButton setBackgroundColor:[UIColor redColor]];
    }
    
    if ([_serialNumberButton.titleLabel.text integerValue] <= 3) {
        [_serialNumberButton setBackgroundColor:[UIColor redColor]];
        [_serialNumberButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    } else {
        [_serialNumberButton setBackgroundColor:[UIColor whiteColor]];
        [_serialNumberButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }
}

- (void)setFrame:(CGRect)frame{
    frame.size.height -= 5;
    [super setFrame:frame];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
