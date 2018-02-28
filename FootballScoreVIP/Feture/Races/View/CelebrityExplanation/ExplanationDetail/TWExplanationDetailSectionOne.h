//
//  TWExplanationDetailSectionOne.h
//  105CP
//
//  Created by 田伟 on 2017/11/9.
//  Copyright © 2017年 宋辉. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TWExplanationDetailModel;

@interface TWExplanationDetailSectionOne : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *authNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *authTagImageView;
@property (weak, nonatomic) IBOutlet UILabel *authdescriptionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *lotterytypeImageView;

@property (weak, nonatomic) IBOutlet UILabel *plantitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *lotterytypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *isSeeLabel;
@property (weak, nonatomic) IBOutlet UILabel *releaseTimeLabel;
@property (weak, nonatomic) IBOutlet UIButton *begintimeButton;

@property (nonatomic, strong) TWExplanationDetailModel * model;


@end
