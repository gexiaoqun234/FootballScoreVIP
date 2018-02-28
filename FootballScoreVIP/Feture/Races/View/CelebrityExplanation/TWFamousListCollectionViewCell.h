//
//  TWFamousListCollectionViewCell.h
//  105CP
//
//  Created by 田伟 on 2017/11/3.
//  Copyright © 2017年 宋辉. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TWFamousListsModel;

@interface TWFamousListCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (nonatomic, strong) TWFamousListsModel * model;

@end
