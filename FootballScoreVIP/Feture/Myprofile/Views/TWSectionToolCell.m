//
//  TWSectionToolCell.m
//  105CP
//
//  Created by 田伟 on 2017/11/16.
//  Copyright © 2017年 宋辉. All rights reserved.
//

#import "TWSectionToolCell.h"

@implementation TWSectionToolCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setMineModel:(AccountModel *)mineModel{
    _mineModel = mineModel;
    
    if ([[AccountTool sharedAccountTool] isLogin]) {
        // 认证按钮
        if ([mineModel.isBinding isEqualToString:@"0"]) {
            // 未绑定
            [_attestationButton setImage:[UIImage imageNamed:@"no_attestation"] forState:UIControlStateNormal];
            [_attestationButton setTitle:@"未绑定" forState:UIControlStateNormal];
        } else if ([mineModel.isBinding isEqualToString:@"1"]){
            // 绑定
            [_attestationButton setTitle:@"已绑定" forState:UIControlStateNormal];
            [_attestationButton setImage:[UIImage imageNamed:@"attestation"] forState:UIControlStateNormal];
        }
        
        // 签到按钮
        if ([[NSString stringWithFormat:@"%@",mineModel.isSign] isEqualToString:@"0"]) {
            [_signButton setTitle:@"未签到" forState:UIControlStateNormal];
            [_signButton setImage:[UIImage imageNamed:@"no_sign"] forState:UIControlStateNormal];
        } else if ([[NSString stringWithFormat:@"%@",mineModel.isSign] isEqualToString:@"1"]){
            [_signButton setTitle:@"已签到" forState:UIControlStateNormal];
            [_signButton setImage:[UIImage imageNamed:@"sign"] forState:UIControlStateNormal];
        }
        
        // 等级按钮
        if ([[NSString stringWithFormat:@"%@",mineModel.level] isEqualToString:@"0"]) {
            [_integralButton setTitle:@"等级" forState:UIControlStateNormal];
            [_integralButton setImage:[UIImage imageNamed:@"grade"] forState:UIControlStateNormal];
        } else {
            [_integralButton setTitle:[NSString stringWithFormat:@"等级：%@",mineModel.level] forState:UIControlStateNormal];
            [_integralButton setImage:[UIImage imageNamed:[NSString stringWithFormat:@"grade%@",mineModel.level]] forState:UIControlStateNormal];
        }
        
        // 积分按钮
        if ([[NSString stringWithFormat:@"%@",mineModel.score] isEqualToString:@"0"]){
            [_gradeButton setTitle:@"无积分" forState:UIControlStateNormal];
            [_gradeButton setImage:[UIImage imageNamed:@"no_integral"] forState:UIControlStateNormal];
        } else {
            [_gradeButton setTitle:[NSString stringWithFormat:@"积分 %@",mineModel.score] forState:UIControlStateNormal];
            [_gradeButton setImage:[UIImage imageNamed:@"integral"] forState:UIControlStateNormal];
        }
    } else {
        // 认证按钮未绑定
        [_attestationButton setImage:[UIImage imageNamed:@"no_attestation"] forState:UIControlStateNormal];
        // 签到按钮
        [_signButton setTitle:@"未签到" forState:UIControlStateNormal];
        [_signButton setImage:[UIImage imageNamed:@"no_sign"] forState:UIControlStateNormal];
        // 等级按钮
        [_integralButton setTitle:@"等级" forState:UIControlStateNormal];
        [_integralButton setImage:[UIImage imageNamed:@"grade"] forState:UIControlStateNormal];
        // 积分
        [_gradeButton setTitle:@"无积分" forState:UIControlStateNormal];
        [_gradeButton setImage:[UIImage imageNamed:@"no_integral"] forState:UIControlStateNormal];
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)attestationButtonClick:(TWFastButton *)sender {
    if ([self.delegate respondsToSelector:@selector(attestationButtonDidClick)]) {
        [self.delegate attestationButtonDidClick];
    }
}

- (IBAction)signButtonClick:(TWFastButton *)sender {
    if ([self.delegate respondsToSelector:@selector(signButtonDidClick)]) {
        [self.delegate signButtonDidClick];
    }
}

- (IBAction)gradeButtonClick:(TWFastButton *)sender {
    if ([self.delegate respondsToSelector:@selector(gradeButtonDidClick)]) {
        [self.delegate gradeButtonDidClick];
    }
}

- (IBAction)integralButtonClick:(TWFastButton *)sender {
    if ([self.delegate respondsToSelector:@selector(integralButtonDidClick)]) {
        [self.delegate integralButtonDidClick];
    }
}
@end
