//
//  TWPFDetailTwoCell.m
//  105CP
//
//  Created by 田伟 on 2017/11/6.
//  Copyright © 2017年 宋辉. All rights reserved.
//

#import "TWPFDetailTwoCell.h"
#import "TWPhoneFollowDetailModel.h"
#import "TWPhoneFollowDetailResultsModel.h"

@implementation TWPFDetailTwoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    NSMutableAttributedString * attributedText = [[NSMutableAttributedString alloc]initWithString:@"「近期战绩」"];
    NSUInteger len = attributedText.length - 2;
    NSRange range = NSMakeRange(1, len);
    [attributedText addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range];
    _recentRecordLabel.attributedText = attributedText;
}

- (void)setModel:(TWPhoneFollowDetailModel *)model{
    _model = model;
    _profitLabel.text = [NSString stringWithFormat:@"%@%%",model.profit];
    _weekhitLabel.text = [NSString stringWithFormat:@"%@中%@",model.allnum,model.hitnum];
    _monthHitLabel.text = [NSString stringWithFormat:@"%@中%@",model.iallnumMonth,model.ihitnumMonth];
    _iawardLabel.text = [NSString stringWithFormat:@"%@元",model.iaward];
    
    
    // 设置状态表
    /*
     注意☆注意：
     
     1:_state4和_state5 调过来了
     2:并不是每期都买的，有3种状态（未买，买了未中和买了中了）
     
     暂时先这么写
     */
    if (model.results.count == 5) {
        _state4.image = [UIImage imageNamed:[model.results[0].newismoney isEqual: @"1"] ? @"tw_win" : @"tw_noWin"];
        _state5.image = [UIImage imageNamed:[model.results[1].newismoney isEqual: @"1"] ? @"tw_win" : @"tw_noWin"];
        _state3.image = [UIImage imageNamed:[model.results[2].newismoney isEqual: @"1"] ? @"tw_win" : @"tw_noWin"];
        _state2.image = [UIImage imageNamed:[model.results[3].newismoney isEqual: @"1"] ? @"tw_win" : @"tw_noWin"];
        _state1.image = [UIImage imageNamed:[model.results[4].newismoney isEqual: @"1"] ? @"tw_win" : @"tw_noWin"];
    } else if (model.results.count == 4) {
        _state4.image = [UIImage imageNamed:[model.results[0].newismoney isEqual: @"1"] ? @"tw_win" : @"tw_noWin"];
        _state5.image = [UIImage imageNamed:[model.results[1].newismoney isEqual: @"1"] ? @"tw_win" : @"tw_noWin"];
        _state3.image = [UIImage imageNamed:[model.results[2].newismoney isEqual: @"1"] ? @"tw_win" : @"tw_noWin"];
        _state2.image = [UIImage imageNamed:[model.results[3].newismoney isEqual: @"1"] ? @"tw_win" : @"tw_noWin"];
        _state1.image = [UIImage imageNamed:@"tw_wuWin"];
    } else if (model.results.count == 3) {
        _state4.image = [UIImage imageNamed:[model.results[0].newismoney isEqual: @"1"] ? @"tw_win" : @"tw_noWin"];
        _state5.image = [UIImage imageNamed:[model.results[1].newismoney isEqual: @"1"] ? @"tw_win" : @"tw_noWin"];
        _state3.image = [UIImage imageNamed:[model.results[2].newismoney isEqual: @"1"] ? @"tw_win" : @"tw_noWin"];
        _state2.image = [UIImage imageNamed:@"tw_wuWin"];
        _state1.image = [UIImage imageNamed:@"tw_wuWin"];
    } else if (model.results.count == 2) {
        _state4.image = [UIImage imageNamed:[model.results[0].newismoney isEqual: @"1"] ? @"tw_win" : @"tw_noWin"];
        _state5.image = [UIImage imageNamed:[model.results[1].newismoney isEqual: @"1"] ? @"tw_win" : @"tw_noWin"];
        _state3.image = [UIImage imageNamed:@"tw_wuWin"];
        _state2.image = [UIImage imageNamed:@"tw_wuWin"];
        _state1.image = [UIImage imageNamed:@"tw_wuWin"];
    } else if (model.results.count == 1) {
        _state4.image = [UIImage imageNamed:[model.results[0].newismoney isEqual: @"1"] ? @"tw_win" : @"tw_noWin"];
        _state5.image = [UIImage imageNamed:@"tw_wuWin"];
        _state3.image = [UIImage imageNamed:@"tw_wuWin"];
        _state2.image = [UIImage imageNamed:@"tw_wuWin"];
        _state1.image = [UIImage imageNamed:@"tw_wuWin"];
    } else {
        _state4.image = [UIImage imageNamed:@"tw_wuWin"];
        _state5.image = [UIImage imageNamed:@"tw_wuWin"];
        _state3.image = [UIImage imageNamed:@"tw_wuWin"];
        _state2.image = [UIImage imageNamed:@"tw_wuWin"];
        _state1.image = [UIImage imageNamed:@"tw_wuWin"];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
