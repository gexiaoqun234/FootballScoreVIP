//
//  TWPFDetailListCell.m
//  105CP
//
//  Created by 田伟 on 2017/11/6.
//  Copyright © 2017年 宋辉. All rights reserved.
//

#import "TWPFDetailListCell.h"
#import "TWFollowUserListModel.h"

@implementation TWPFDetailListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _resultButton.layer.cornerRadius = 4;
    _resultButton.layer.masksToBounds = YES;
    
    // 中奖label顺时针旋转15°
    _winMoneyLabel.transform = CGAffineTransformMakeRotation(15 * M_PI / 180.0);
}

- (void)setModel:(TWFollowUserListModel *)model{
    _model = model;
    _typeLabel.text = model.type;
    _cendtimeLable.text = [self detailTimeString:model.cendtime];
    _isoverLabel.text = [model.isover isEqualToString:@"1"] ? @"已截止" : @"";
    _perMoneyLabel.text = [NSString stringWithFormat:@"%@元起投",model.perMoney];
    _noteLabel.text = model.note;
    _zjmoneyLabel.attributedText = [self detailNumberLabel:[NSString stringWithFormat:@"自购 %@元",model.zjmoney]];
    _canCopyNumLabel.attributedText = [self detailNumberLabel:[NSString stringWithFormat:@"跟单 %@人",model.canCopyNum]];
    
    //   待开奖
    if ([model.result isEqualToString:@"待开奖"]) {
        _resultButton.hidden = NO;
        _bonusImageView.hidden = YES;
        _winMoneyLabel.hidden = YES;
    } else if ([model.result isEqualToString:@"已中奖"]) {
        _resultButton.hidden = YES;
        _bonusImageView.hidden = NO;
        _winMoneyLabel.hidden = NO;
        _winMoneyLabel.text = [NSString stringWithFormat:@"¥%@",model.winMoney];
    } else {
        // 未中奖
        _resultButton.hidden = YES;
        _bonusImageView.hidden = YES;
        _winMoneyLabel.hidden = YES;
    }
}

- (NSString *)detailTimeString:(NSString *)timeString{
    // "cendtime": "2017-11-05 21:50:00",
    NSUInteger loc = 5;
    NSUInteger len = 11;
    NSRange range = NSMakeRange(loc, len);
    return [timeString substringWithRange:range];
}

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
    frame.size.height -= 2;
    [super setFrame:frame];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
