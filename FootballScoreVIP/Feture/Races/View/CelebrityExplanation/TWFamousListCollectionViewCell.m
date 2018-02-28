//
//  TWFamousListCollectionViewCell.m
//  105CP
//
//  Created by 田伟 on 2017/11/3.
//  Copyright © 2017年 宋辉. All rights reserved.
//

#import "TWFamousListCollectionViewCell.h"
#import "TWFamousListsModel.h"

@implementation TWFamousListCollectionViewCell

- (void)setModel:(TWFamousListsModel *)model{
    _model = model;
    
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:model.authheadImlUrl] placeholderImage:[UIImage imageNamed:@"tw_rec_circle_more"]];
    _nameLabel.text = model.authName;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _iconImageView.layer.cornerRadius = (FamousListCollectionCellWeight - 20) * 0.5;
    _iconImageView.layer.masksToBounds = YES;
    self.layer.borderColor = TWColorRGB(242, 242, 242).CGColor;
    self.layer.borderWidth = 0.5;
}

@end
