//
//  TWHotLstCell.m
//  105CP
//
//  Created by 田伟 on 2017/11/2.
//  Copyright © 2017年 宋辉. All rights reserved.
//

#import "TWHotLstCell.h"
#import "SHHotListModel.h"

@implementation TWHotLstCell

- (void)setModel:(SHHotListModel *)model{
    _model = model;
    [_imageUrlImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",InterfaceHeader,model.imageUrl]] placeholderImage:[UIImage imageNamed:@"HeadSculpture"]];
    _nickNameLabel.text = model.nickname;
    // 几中几
    _allHitNumLabel.text = [NSString stringWithFormat:@"%@中%@",model.allnum,model.hitnum];
    // 拼接一个%
    _profitLabel.text = [NSString stringWithFormat:@"%@%%",model.profit];
    _cendtimeLabel.text = model.cendtime;
    
    // 累计中奖
    _iawardLabel.attributedText = [self detailIawardString:model.iaward];
    
    // 每份几元
    _perMoneyLabel.text = [NSString stringWithFormat:@"%@元起投",model.perMoney];
    
    _noteLabel.text = model.note;
    
    // 自购
    _itmoneyLabel.attributedText = [self datailItmoneyString:model.itmoney];
    // 跟单
    _copycountLabel.attributedText = [self datailCopycountString:model.copycount];
}



// 将传来的数字字符串按千分位
- (NSString *)detailNumber:(NSString *)number{
    NSNumberFormatter * formatter = [[NSNumberFormatter alloc]init];
    formatter.numberStyle = kCFNumberFormatterDecimalStyle;
    return [formatter stringFromNumber:[NSNumber numberWithInteger:[number integerValue]]];
}

// 将传来的数字按千分位
- (NSString *)detailFloatNumber:(CGFloat)number{
    NSNumberFormatter * formatter = [[NSNumberFormatter alloc]init];
    formatter.numberStyle = kCFNumberFormatterDecimalStyle;
    return [formatter stringFromNumber:[NSNumber numberWithFloat:number]];
}

// 处理跟单
- (NSMutableAttributedString *)datailCopycountString:(NSString *)copycount{
    NSMutableAttributedString * attrString = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@人",[self detailNumber:copycount]]];
    NSUInteger len = attrString.length - 1;
    NSRange range = NSMakeRange(0, len);
    [attrString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
    return attrString;
}

// 处理自购
- (NSMutableAttributedString *)datailItmoneyString:(NSString *)itmoney{
    // 数字部分设置红色
    NSMutableAttributedString * attrString = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@元",[self detailNumber:itmoney]]];
    NSUInteger len = attrString.length - 1;
    NSRange range = NSMakeRange(0, len);
    [attrString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
    return attrString;
}

// 处理中奖金额
- (NSMutableAttributedString *)detailIawardString:(NSString *)iaward{
    NSMutableAttributedString * attrString;
    double money = [iaward doubleValue];
    if (money > 1000000.0) {
        // 超过百万的显示我XXX万
        double newMoney = money / 10000;
        attrString = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"累计中奖%.0f万",newMoney]];
        NSUInteger len = attrString.length - 4;
        NSRange range = NSMakeRange(4, len);
        [attrString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
    } else {
        // 待做：累计中奖金额在百万以下的要千位分
        attrString = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"累计中奖%.2f元",money]];
        NSUInteger len = attrString.length - 4 - 1;
        NSRange range = NSMakeRange(4, len);
        [attrString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
    }
    return attrString;
}

- (void)setFrame:(CGRect)frame{
    frame.size.height -= 5;
    [super setFrame:frame];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _allHitNumLabel.layer.cornerRadius = 2;
    _allHitNumLabel.layer.masksToBounds = YES;
    
    _cFButton.layer.cornerRadius = 3;
    _cFButton.layer.masksToBounds = YES;
    
    _imageUrlImageView.layer.cornerRadius = 25;
    _imageUrlImageView.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//- (RACSubject *)redDanTuanButtonSingal{
//    if (!_redDanTuanButtonSingal) {
//        _redDanTuanButtonSingal = [RACSubject subject];
//    }
//    return _redDanTuanButtonSingal;
//}

- (IBAction)coverRedDanTuanButtonClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(coverRedDanTuanButtonDidClickDelegate:)]) {
        [self.delegate coverRedDanTuanButtonDidClickDelegate:self];
    }
//    [_redDanTuanButtonSingal sendNext:sender];
}
@end
