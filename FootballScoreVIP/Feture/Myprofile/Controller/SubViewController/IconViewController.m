//
//  IconViewController.m
//  QQCP30
//
//  Created by 田伟 on 2017/7/21.
//  Copyright © 2017年 魔曦. All rights reserved.
//

#import "IconViewController.h"
#import "TWLoginData.h"
#import "TWLoginNetworkTool.h"

@interface IconViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
- (IBAction)dismissButtonClcik:(UIButton *)sender;
- (IBAction)showMoreButtonClick:(UIButton *)sender;
@end

@implementation IconViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人头像";
    AccountModel * model = [[AccountTool sharedAccountTool] readAccount];
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:model.imgPath]];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}

- (IBAction)dismissButtonClcik:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)showMoreButtonClick:(UIButton *)sender {
    UIAlertController * alertVc = [UIAlertController alertControllerWithTitle:nil message:@"修改个人头像~" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction * camera = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // 判断数据源是否可用
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            return;
        }
        UIImagePickerController * pickerVc = [[UIImagePickerController alloc]init];
        pickerVc.allowsEditing = YES;
        pickerVc.delegate = self;
        //设置拍照后的图片可被编辑
        pickerVc.allowsEditing = YES;
        pickerVc.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:pickerVc animated:YES completion:nil];
    }];
    UIAlertAction * album = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // 判断数据源是否可用
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            return;
        }
        UIImagePickerController * pickerVc = [[UIImagePickerController alloc]init];
        pickerVc.delegate = self;
        pickerVc.allowsEditing = YES;
        pickerVc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:pickerVc animated:YES completion:nil];
    }];
    UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {}];
    [alertVc addAction:camera];
    [alertVc addAction:album];
    [alertVc addAction:cancel];
    [self presentViewController:alertVc animated:YES completion:nil];
}

#pragma mark -- UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"]){
        NSString *key = nil;
        if (picker.allowsEditing){
            key = UIImagePickerControllerEditedImage;
        } else {
            key = UIImagePickerControllerOriginalImage;
        }
        //获取图片
        UIImage *image = [info objectForKey:key];
        NSString * imageStr = [self image2DataURL:image];
        AccountModel * model = [[AccountTool sharedAccountTool] readAccount];
        NSMutableDictionary * parameters = [NSMutableDictionary dictionary];
        [parameters setObject:model.userId forKey:TWUserID];
        [parameters setObject:imageStr forKey:TWBaseStr];
        [SVProgressHUD show];
        
        [[TWLoginNetworkTool shareInstance] requsetMethodType:LoginPOST urlString:TWuploadFileUrl parameters:parameters success:^(id responseObject) {
            if ([responseObject[@"errorcode"] isEqualToString:@"0"]) {
                [SVProgressHUD showSuccessWithStatus:@"头像上传成功~"];
                
                // 修改账号中的图片地址
                AccountModel * model = [[AccountTool sharedAccountTool] readAccount];
                model.imgPath = responseObject[@"result"][@"imgPath"];
                TWLog(@"修改后的头像的地址：%@",responseObject[@"result"][@"imgPath"]);
                
                // 将账户对象设置到单例对象中
                [AccountTool sharedAccountTool].accountModel = model;
                [NSKeyedArchiver archiveRootObject:model toFile:[AccountTool sharedAccountTool].accountPath];
                
                // 发送通知让个人页面刷新头部
                [[NSNotificationCenter defaultCenter] postNotificationName:TWPersonageVcRefreshHeaderNotification object:nil];
                [picker dismissViewControllerAnimated:YES completion:^{
                    self.iconImageView.image = image;
                }];
            } else {
                [SVProgressHUD showErrorWithStatus:responseObject[@"error"]];
                [picker dismissViewControllerAnimated:YES completion:nil];
            }
        } failure:^(NSError *error) {
            [picker dismissViewControllerAnimated:YES completion:nil];
        }];
    }
}

// 将图片对象转成base64的字符串
- (NSString *)image2DataURL: (UIImage *) image{
    NSData *imageData = nil;
    NSString *mimeType = nil;
    imageData = UIImageJPEGRepresentation(image, 0.5f);
    mimeType = @"image/jpeg";
    return [NSString stringWithFormat:@"%@",[imageData base64EncodedStringWithOptions: 0]];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
