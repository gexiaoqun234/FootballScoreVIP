//
//  TWExplanationDetailSectionTwo.m
//  105CP
/**
 *  .--,       .--,
 * ( (  \.---./  ) )
 *  '.__/o   o\__.'
 *     {=  ^  =}
 *      >  -  <
 *     /       \
 *    //       \\
 *   //|   .   |\\
 *   "'\       /'"_.-~^`'-.
 *      \  _  /--'         `
 *    ___)( )(___
 *   (((__) (__)))    高山仰止,景行行止.虽不能至,心向往之。
 */
//  Created by 田伟 on 2017/11/9.
//  Copyright © 2017年 宋辉. All rights reserved.
//

#import "TWExplanationDetailSectionTwo.h"
#import "TWExplanationDetailModel.h"
#import "TWPlanforecastitemTableView.h"

@implementation TWExplanationDetailSectionTwo

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

}


- (void)setModel:(TWExplanationDetailModel *)model{
    _model = model;
    _planforecastitemTableView.model = model;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
