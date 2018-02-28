//
//  SHSectionOneCell.h
//  105CP
//
//  Created by 田伟 on 2017/11/1.
//  Copyright © 2017年 宋辉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SHCustomButton.h"

@protocol SHSectionOneCellDelegate <NSObject>
- (void)hitButtonDidClick;
- (void)winButtonDidClick;
- (void)atantionButtonDidClick;
- (void)customButtonDidClick;
@end

@interface SHSectionOneCell : UITableViewCell
@property (nonatomic, weak)id <SHSectionOneCellDelegate> delegate;
- (IBAction)hitButtonClick:(SHCustomButton *)sender;
- (IBAction)winButtonClick:(SHCustomButton *)sender;
- (IBAction)atantionButtonClick:(SHCustomButton *)sender;
- (IBAction)customButtonClick:(SHCustomButton *)sender;

@end
