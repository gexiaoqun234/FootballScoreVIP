//
//  SHDiscoverCell.h
//  105CP
//
//  Created by 田伟 on 2017/11/1.
//  Copyright © 2017年 宋辉. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SHDiscoverModel;

@interface SHDiscoverCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *tw_titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *tw_subTitleLable;
@property (nonatomic, strong) SHDiscoverModel * model;
@end
