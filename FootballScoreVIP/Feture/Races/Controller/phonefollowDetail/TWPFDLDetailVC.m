//
//  TWPFDLDetailVC.m
//  105CP
//
//  Created by 田伟 on 2017/11/6.
//  Copyright © 2017年 宋辉. All rights reserved.
//

#import "TWPFDLDetailVC.h"
#import "TWHotListDetail.h"
#import "TWFollowUserListModel.h"
#import "TWSubHLView.h"

static NSString * const TWcowner = @"cowner";
static NSString * const TWpassword = @"password";
static NSString * const TWplanNo = @"planNo";
static NSString * const TWuser = @"user";
static NSString * const TWversion = @"version";

@interface TWPFDLDetailVC ()
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *allHitNumLabel;
@property (weak, nonatomic) IBOutlet UIButton *attentionButton;
@property (weak, nonatomic) IBOutlet UILabel *icopyawardLabel;
@property (weak, nonatomic) IBOutlet UILabel *profitLabel;

@property (weak, nonatomic) IBOutlet UIView *discreptionView;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *passLabel;
@property (weak, nonatomic) IBOutlet UILabel *retuenLabel;
@property (weak, nonatomic) IBOutlet UILabel *noteLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *multipleLabel;
@property (weak, nonatomic) IBOutlet UILabel *perMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *projidLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (nonatomic, strong)TWHotListDetail * detailModel;
@property (nonatomic, strong) TWSubHLView * subHLView;
@end

@implementation TWPFDLDetailVC

- (TWSubHLView *)subHLView{
    if (!_subHLView) {
        CGFloat y = CGRectGetMaxY(self.discreptionView.frame) + 10;
        CGFloat height = TWScreenHeight - y - 10 - (TWNaviHeight);
        _subHLView = [[TWSubHLView alloc]initWithFrame:CGRectMake(0, y, TWScreenWidth, height)];
        [self.view addSubview:_subHLView];
    }
    return _subHLView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [SVProgressHUD show];
    self.title = @"跟单详情";
    // 调整子控件样式
    [self initSubViews];
    // 隐藏各视图
    self.headerView.hidden = YES;
    self.discreptionView.hidden = YES;
    self.subHLView.hidden = YES;
    [self loadNewData];
}

- (void)initSubViews{
    _iconImageView.layer.cornerRadius = 30;
    _iconImageView.layer.masksToBounds = YES;
    _attentionButton.layer.cornerRadius = 2;
//    _attentionButton.layer.masksToBounds = YES;
//    _attentionButton.layer.borderWidth = 1;
//    _attentionButton.layer.borderColor = [UIColor redColor].CGColor;
}

// 刷新数据
- (void)loadNewData{
    NSMutableDictionary * parameters = [NSMutableDictionary dictionary];
    parameters[TWcowner] = self.model.projid;
    parameters[TWpassword] = @"";
    parameters[TWplanNo] = self.model.projid;
    parameters[TWuser] = @"";
    parameters[TWversion] = @"24";
    [[SHNetworkTool shareInstance] getDiscoverCopyFollowHotListShowDetailDataWith:parameters Success:^(TWHotListDetail *datailData) {
        _detailModel = datailData;
        // 赋值
        [_iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",InterfaceHeader,_detailModel.imageUrl]] placeholderImage:[UIImage imageNamed:@"HeadSculpture"]];
        _nickNameLabel.text = _detailModel.author;
        _allHitNumLabel.text = [NSString stringWithFormat:@"%@中%@",_detailModel.allnum,_detailModel.hitnum];
        _icopyawardLabel.attributedText = [self detailIawardString:_detailModel.iaward];
        _profitLabel.text = [NSString stringWithFormat:@"单位回报：%@%%",_detailModel.profit];
        _typeLabel.text = _detailModel.type;
        _passLabel.text = _detailModel.pass;
        _retuenLabel.text = @"--倍";
        _noteLabel.text = _detailModel.cdesc;
        _moneyLabel.text = _detailModel.money;
        _multipleLabel.text = _detailModel.multiple;
        _perMoneyLabel.text = _detailModel.projid;
        _projidLabel.text = [NSString stringWithFormat:@"%@元起投",_detailModel.perMoney];
        _timeLabel.text = _detailModel.addtime;
        
        // 传值
        self.subHLView.projidString = self.model.projid;
        
        // 显示控件
        self.headerView.hidden = NO;
        self.discreptionView.hidden = NO;
        self.subHLView.hidden = NO;

        [SVProgressHUD dismiss];
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
    }];
}


// 处理中奖金额
- (NSMutableAttributedString *)detailIawardString:(NSString *)iaward{
    NSMutableAttributedString * attrString;
    double money = [iaward doubleValue];
    if (money > 1000000.0) {
        // 超过百万的显示我XXX万
        double newMoney = money / 10000;
        attrString = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"创造价值：%.0f万",newMoney]];
        NSUInteger len = attrString.length - 4;
        NSRange range = NSMakeRange(4, len);
        [attrString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
    } else {
        // 待做：累计中奖金额在百万以下的要千位分
        attrString = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"创造价值：%.2f元",money]];
        NSUInteger len = attrString.length - 4 - 1;
        NSRange range = NSMakeRange(4, len);
        [attrString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
    }
    return attrString;
}

- (IBAction)attentionButtonClick:(UIButton *)sender {
//    [SVProgressHUD showErrorWithStatus:@"请先登录"];
//    [SVProgressHUD dismissWithDelay:0.5 completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
