//
//  SHSectionTwoCell.m
//  105CP
//
//  Created by 田伟 on 2017/11/1.
//  Copyright © 2017年 宋辉. All rights reserved.
//

#import "SHSectionTwoCell.h"
#import "SHRedUserView.h"
#import "SHRedUserModel.h"

@implementation SHSectionTwoCell

- (void)setUserArray:(NSArray<SHRedUserModel *> *)userArray{
    _userArray = userArray;
    _redUserView.redArray = userArray;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
