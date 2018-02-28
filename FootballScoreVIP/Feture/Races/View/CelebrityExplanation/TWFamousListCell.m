//
//  TWFamousListCell.m
//  105CP
//
//  Created by 田伟 on 2017/11/3.
//  Copyright © 2017年 宋辉. All rights reserved.
//

#import "TWFamousListCell.h"
#import "TWFamousListCollectionView.h"

@implementation TWFamousListCell

- (void)setListArray:(NSMutableArray<TWFamousListsModel *> *)listArray{
    _listArray = listArray;
    _tw_contentView.listArray = listArray;
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
