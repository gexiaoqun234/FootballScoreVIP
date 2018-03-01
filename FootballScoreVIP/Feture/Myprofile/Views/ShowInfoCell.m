//
//  ShowInfoCell.m
//  LotteryAssistant
//
//  Created by 田伟 on 2017/5/25.
//  Copyright © 2017年 个人. All rights reserved.
//

#import "ShowInfoCell.h"
#import "SaveSelectorModel.h"

@implementation ShowInfoCell

- (void)setModel:(SaveSelectorModel *)model{
    _model = model;
    
    _timeLabel.text = [NSString stringWithFormat:@"选号保存日期：%@",model.time];
    _typeLabel.text = model.type;
    
    NSMutableString * redStr = [NSMutableString stringWithString:@"红球号码："];
    for (NSInteger i = 0; i < _model.redArr.count; i++) {
        [redStr appendString:_model.redArr[i]];
        [redStr appendString:@" "];
    }
    _redLable.text = redStr;

    
    NSMutableString * blueStr = [NSMutableString stringWithString:@"篮球号码："];
    for (NSInteger i = 0; i < _model.blueArr.count; i++) {
        [blueStr appendString:_model.blueArr[i]];
        [blueStr appendString:@" "];
    }
    _blueLabel.text = blueStr;
}

- (void)setFrame:(CGRect)frame{
    frame.size.height -= TWMargin;
    [super setFrame:frame];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentView.backgroundColor = TWColorRGB(245, 245, 245);
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
