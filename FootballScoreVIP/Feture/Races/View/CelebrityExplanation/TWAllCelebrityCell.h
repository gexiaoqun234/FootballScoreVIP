//
//  TWAllCelebrityCell.h
//  105CP
//
//  Created by 田伟 on 2017/11/13.
//  Copyright © 2017年 宋辉. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TWFamousListsModel;

@interface TWAllCelebrityCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *authNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *authdescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *explansLabel;
@property (weak, nonatomic) IBOutlet UIImageView *jtypeImageView;
@property (weak, nonatomic) IBOutlet UIImageView *authTagImageView;

@property (nonatomic, strong) TWFamousListsModel * model;
@end
