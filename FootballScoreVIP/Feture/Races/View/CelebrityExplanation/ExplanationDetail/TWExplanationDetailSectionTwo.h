//
//  TWExplanationDetailSectionTwo.h
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

#import <UIKit/UIKit.h>
@class TWExplanationDetailModel;
@class TWPlanforecastitemTableView;

@interface TWExplanationDetailSectionTwo : UITableViewCell
@property (weak, nonatomic) IBOutlet TWPlanforecastitemTableView *planforecastitemTableView;
@property (nonatomic, strong) TWExplanationDetailModel * model;
@end
