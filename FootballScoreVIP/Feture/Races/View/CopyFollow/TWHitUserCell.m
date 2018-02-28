//
//  TWHitUserCell.m
//  105CP
//
//  Created by 田伟 on 2017/11/6.
//  Copyright © 2017年 宋辉. All rights reserved.
//

#import "TWHitUserCell.h"
#import "TWHitModel.h"

@implementation TWHitUserCell

- (void)setModel:(TWHitModel *)model{
    _model = model;
    
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",InterfaceHeader,model.imageUrl]] placeholderImage:[UIImage imageNamed:@"HeadSculpture"]];
    _nickNameLabel.text = model.nickname;
    
    _allHitLabel.attributedText = [self detailNumberLabel:[NSString stringWithFormat:@"%@中%@",model.allnum,model.hitnum]];
    
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
    
    if ([_SerialNumberButton.titleLabel.text integerValue] <= 3) {
        [_SerialNumberButton setBackgroundColor:[UIColor redColor]];
        [_SerialNumberButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    } else {
        [_SerialNumberButton setBackgroundColor:[UIColor whiteColor]];
        [_SerialNumberButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }
}

// 处理战绩
- (NSMutableAttributedString *)detailNumberLabel:(NSString *)lableString{
    NSArray *number = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"];
    NSMutableAttributedString *attributeString  = [[NSMutableAttributedString alloc]initWithString:lableString];
    for (int i = 0; i < lableString.length; i ++) {
        //这里的小技巧，每次只截取一个字符的范围
        NSString *a = [lableString substringWithRange:NSMakeRange(i, 1)];
        //判断装有0-9的字符串的数字数组是否包含截取字符串出来的单个字符，从而筛选出符合要求的数字字符的范围NSMakeRange
        if ([number containsObject:a]) {
            [attributeString setAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} range:NSMakeRange(i, 1)];
        }
    }
    return attributeString;
}

- (void)setFrame:(CGRect)frame{
    frame.size.height -= 5;
    [super setFrame:frame];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _iconImageView.layer.cornerRadius = 25;
    _iconImageView.layer.masksToBounds = YES;
    
    _canCopyNumButton.layer.cornerRadius = 3;
    _canCopyNumButton.layer.masksToBounds = YES;
    
    _SerialNumberButton.layer.cornerRadius = 15;
    _SerialNumberButton.layer.masksToBounds = YES;
    _SerialNumberButton.layer.borderColor = [UIColor redColor].CGColor;
    _SerialNumberButton.layer.borderWidth = 1;
    
    _tw_copyNumButton.layer.cornerRadius = 8;
    _tw_copyNumButton.layer.masksToBounds = YES;
    _tw_copyNumButton.layer.borderColor = [UIColor redColor].CGColor;
    _tw_copyNumButton.layer.borderWidth = 1;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
