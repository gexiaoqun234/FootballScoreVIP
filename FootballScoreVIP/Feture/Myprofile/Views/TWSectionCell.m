//
//  TWSectionCell.m
//  105CP
//
//  Created by 田伟 on 2017/11/16.
//  Copyright © 2017年 宋辉. All rights reserved.
//

#import "TWSectionCell.h"

@implementation TWSectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setFrame:(CGRect)frame{
    frame.size.height -= 1;
    [super setFrame:frame];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
