//
//  TWNewsCell.h
//  105CP
//
//  Created by 田伟 on 2017/11/7.
//  Copyright © 2017年 宋辉. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TWNewsModel;

@interface TWNewsCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageImageView;
@property (weak, nonatomic) IBOutlet UILabel *tw_titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *pubdateLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentsLabel;

@property (nonatomic, strong) TWNewsModel * model;
@end
