//
//  TWSectionToolCell.h
//  105CP
//
//  Created by 田伟 on 2017/11/16.
//  Copyright © 2017年 宋辉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TWFastButton.h"

@protocol TWSectionToolCellDelagate <NSObject>
- (void)attestationButtonDidClick;
- (void)signButtonDidClick;
- (void)gradeButtonDidClick;
- (void)integralButtonDidClick;
@end

@interface TWSectionToolCell : UITableViewCell

@property (weak, nonatomic) IBOutlet TWFastButton *attestationButton;   // 认证按钮
@property (weak, nonatomic) IBOutlet TWFastButton *signButton;          // 签到按钮
@property (weak, nonatomic) IBOutlet TWFastButton *gradeButton;         // 等级按钮
@property (weak, nonatomic) IBOutlet TWFastButton *integralButton;      // 积分按钮
- (IBAction)attestationButtonClick:(TWFastButton *)sender;
- (IBAction)signButtonClick:(TWFastButton *)sender;
- (IBAction)gradeButtonClick:(TWFastButton *)sender;
- (IBAction)integralButtonClick:(TWFastButton *)sender;
@property (nonatomic, weak)id <TWSectionToolCellDelagate> delegate;

@property (nonatomic, strong) AccountModel * mineModel;
@end
