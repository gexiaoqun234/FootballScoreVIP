//
//  TWNoticeCell.m
//  105CP
//
//  Created by 田伟 on 2017/11/5.
//  Copyright © 2017年 宋辉. All rights reserved.
//

#import "TWNoticeCell.h"

@implementation TWNoticeCell

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
