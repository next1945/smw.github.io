//
//  NYSLoginViewController.m
//  AppDemo
//
//  Created by 倪刚 on 2018/10/24.
//  Copyright © 2018 NiYongsheng. All rights reserved.
//

#import "NYSLoginViewController.h"
#import "NYSTabViewController.h"
#import "NYSQQUserInfoModel.h"
#import "NYSWeChatUserinfoModel.h"
#import <UMShare/UMShare.h>

#import "NYSForgetPasswordViewController.h"
#import "NYSRegisterViewController.h"

@interface NYSLoginViewController ()
@property (weak, nonatomic) NYSWeChatUserinfoModel *wechatUserinfo;
@property (weak, nonatomic) NYSQQUserInfoModel *qqUserinfo;

@property (weak, nonatomic) IBOutlet UITextField *account;
@property (weak, nonatomic) IBOutlet UITextField *password;

- (IBAction)forgetPassword:(id)sender;
- (IBAction)regist:(id)sender;

- (IBAction)Login:(id)sender;
- (IBAction)wechatLogin:(id)sender;
- (IBAction)qqLogin:(id)sender;

@end

@implementation NYSLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)forgetPassword:(id)sender {
    NYSForgetPasswordViewController *forgetVC = [[NYSForgetPasswordViewController alloc] init];
    forgetVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:forgetVC animated:YES completion:nil];
}

- (IBAction)regist:(id)sender {
    NYSRegisterViewController *registVC = [[NYSRegisterViewController alloc] init];
    registVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:registVC animated:YES completion:nil];
}

- (IBAction)Login:(id)sender {
    if ([_account.text isEqualToString:@"niyongsheng"] && [_password.text isEqualToString:@"123456"]) {
        [SVProgressHUD showSuccessWithStatus:@"登陆成功"];
        [SVProgressHUD dismissWithDelay:1.f];
        
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        [userDefault setObject:_account.text forKey:@"account"];
        [userDefault setObject:[_password.text md5] forKey:@"token"];
        [userDefault synchronize];
        
        [self presentViewController:[[NYSTabViewController alloc] init] animated:YES completion:nil];
    } else {
        [SVProgressHUD showErrorWithStatus:@"密码错误"];
        [SVProgressHUD dismissWithDelay:1.f];
    }
}

- (IBAction)wechatLogin:(id)sender {
    WS(weakSelf);
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_WechatSession currentViewController:nil completion:^(id result, NSError *error) {
        if (error) {
            [SVProgressHUD showErrorWithStatus:error.userInfo[@"message"]];
            [SVProgressHUD dismissWithDelay:5.f];
            NSLog(@"wechat logoin error:%@", error);
        } else {
            UMSocialUserInfoResponse *resp = result;
            
            // 授权信息
            NSLog(@"Wechat uid: %@", resp.uid);
            NSLog(@"Wechat openid: %@", resp.openid);
            NSLog(@"Wechat unionid: %@", resp.unionId);
            NSLog(@"Wechat accessToken: %@", resp.accessToken);
            NSLog(@"Wechat refreshToken: %@", resp.refreshToken);
            NSLog(@"Wechat expiration: %@", resp.expiration);
            
            // 用户信息
            NSLog(@"Wechat name: %@", resp.name);
            NSLog(@"Wechat iconurl: %@", resp.iconurl);
            NSLog(@"Wechat gender: %@", resp.unionGender);
            
            // 第三方平台SDK源数据
            NSLog(@"Wechat originalResponse: %@", resp.originalResponse);
            self.wechatUserinfo = [NYSWeChatUserinfoModel mj_objectWithKeyValues:resp.originalResponse];
            [weakSelf presentViewController:[[NYSTabViewController alloc] init] animated:YES completion:nil];
            
            [SVProgressHUD showSuccessWithStatus:@"登陆成功"];
            [SVProgressHUD dismissWithDelay:1.f];
        }
    }];
}

- (IBAction)qqLogin:(id)sender {
    WS(weakSelf);
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_QQ currentViewController:nil completion:^(id result, NSError *error) {
        if (error) {
            [SVProgressHUD showErrorWithStatus:error.userInfo[@"message"]];
            [SVProgressHUD dismissWithDelay:1.f];
        } else {
            UMSocialUserInfoResponse *resp = result;
            
            // 授权信息
            NSLog(@"QQ uid: %@", resp.uid);
            NSLog(@"QQ openid: %@", resp.openid);
            NSLog(@"QQ unionid: %@", resp.unionId);
            NSLog(@"QQ accessToken: %@", resp.accessToken);
            NSLog(@"QQ expiration: %@", resp.expiration);
            
            // 用户信息
            NSLog(@"QQ name: %@", resp.name);
            NSLog(@"QQ iconurl: %@", resp.iconurl);
            NSLog(@"QQ gender: %@", resp.unionGender);
            
            // 第三方平台SDK源数据
            NSLog(@"QQ originalResponse: %@", resp.originalResponse);
            self.qqUserinfo = [NYSQQUserInfoModel mj_objectWithKeyValues:resp.originalResponse];
            [weakSelf presentViewController:[[NYSTabViewController alloc] init] animated:YES completion:nil];
            
            [SVProgressHUD showSuccessWithStatus:@"登陆成功"];
            [SVProgressHUD dismissWithDelay:1.f];
        }
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
