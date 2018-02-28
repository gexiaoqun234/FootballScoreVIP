//
//  TWExplainListCell.h
//  105CP
//
//  Created by 田伟 on 2017/11/3.
//  Copyright © 2017年 宋辉. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TWExplainListModel;
@class TWExplainListCell;

@protocol TWExplainListCellDelegate <NSObject>
- (void)topTapButtonDidClickDelegate:(TWExplainListCell * )cell;
@end

@interface TWExplainListCell : UITableViewCell
@property (nonatomic, weak) id<TWExplainListCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *authNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *authTagImageView;
@property (weak, nonatomic) IBOutlet UIImageView *lotterytypeImageView;
@property (weak, nonatomic) IBOutlet UILabel *salepeiceLabel;
@property (weak, nonatomic) IBOutlet UILabel *authdescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *tw_titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *lotterytypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *isSeeLabel;
@property (weak, nonatomic) IBOutlet UILabel *begintimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *label10pusl;

@property (weak, nonatomic) IBOutlet UIButton *topTapButton;
- (IBAction)topTapButtonClick:(UIButton *)sender;

@property (nonatomic, strong) TWExplainListModel * model;
@end
