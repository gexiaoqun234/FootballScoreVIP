//
//  TWHotLstCell.h
//  105CP
//
//  Created by 田伟 on 2017/11/2.
//  Copyright © 2017年 宋辉. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SHHotListModel;
@class TWHotLstCell;

@protocol TWHotLstCellDelegate <NSObject>
- (void)coverRedDanTuanButtonDidClickDelegate:(TWHotLstCell *)cell;
@end


@interface TWHotLstCell : UITableViewCell

@property (nonatomic, weak) id<TWHotLstCellDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIImageView *imageUrlImageView;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
// 几中几
@property (weak, nonatomic) IBOutlet UILabel *allHitNumLabel;
// 单位回报率
@property (weak, nonatomic) IBOutlet UILabel *profitLabel;
// （下注）时间
@property (weak, nonatomic) IBOutlet UILabel *cendtimeLabel;
// 累计中奖
@property (weak, nonatomic) IBOutlet UILabel *iawardLabel;
// 二元起投
@property (weak, nonatomic) IBOutlet UILabel *perMoneyLabel;
// 介绍
@property (weak, nonatomic) IBOutlet UILabel *noteLabel;
// 自购
@property (weak, nonatomic) IBOutlet UILabel *itmoneyLabel;
// 跟单人数
@property (weak, nonatomic) IBOutlet UILabel *copycountLabel;
// 立即跟单
@property (weak, nonatomic) IBOutlet UIButton *cFButton;

// 点击cell上部分跳转至红单团详情页面
- (IBAction)coverRedDanTuanButtonClick:(UIButton *)sender;

@property (nonatomic, strong) SHHotListModel * model;
//@property (nonatomic, strong) RACSubject * redDanTuanButtonSingal;
@end
