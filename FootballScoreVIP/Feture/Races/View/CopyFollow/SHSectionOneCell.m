//
//  SHSectionOneCell.m
//  105CP
//
//  Created by 田伟 on 2017/11/1.
//  Copyright © 2017年 宋辉. All rights reserved.
//

#import "SHSectionOneCell.h"

@implementation SHSectionOneCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)hitButtonClick:(SHCustomButton *)sender {
    if ([self.delegate respondsToSelector:@selector(hitButtonDidClick)]) {
        [self.delegate hitButtonDidClick];
    }
}

- (IBAction)winButtonClick:(SHCustomButton *)sender {
    if ([self.delegate respondsToSelector:@selector(winButtonDidClick)]) {
        [self.delegate winButtonDidClick];
    }
}

- (IBAction)atantionButtonClick:(SHCustomButton *)sender {
    if ([self.delegate respondsToSelector:@selector(atantionButtonDidClick)]) {
        [self.delegate atantionButtonDidClick];
    }
}

- (IBAction)customButtonClick:(SHCustomButton *)sender {
    if ([self.delegate respondsToSelector:@selector(customButtonDidClick)]) {
        [self.delegate customButtonDidClick];
    }
}

@end
