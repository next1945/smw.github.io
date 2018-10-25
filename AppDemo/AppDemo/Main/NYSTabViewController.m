//
//  NYSTabViewController.m
//  AppDemo
//
//  Created by 倪刚 on 2018/10/24.
//  Copyright © 2018 NiYongsheng. All rights reserved.
//

#import "NYSTabViewController.h"
#import "NYSHomeViewController.h"
#import "NYSMeViewController.h"
#import "NYSLoginViewController.h"
#import "NYSTabbar.h"

@interface NYSTabViewController ()

@end

@implementation NYSTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(logout) name:@"LogoutNotification" object:nil];
    
    NYSTabbar *myTabBar = [[NYSTabbar alloc] init];
//    [self setValue:myTabBar forKey:@"tabBar"];
    
    UINavigationController *navHome = [[UINavigationController alloc] initWithRootViewController:[[NYSHomeViewController alloc] init]];
    navHome.tabBarItem.image = [[UIImage imageNamed:@"Home"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    navHome.tabBarItem.selectedImage = [[UIImage imageNamed:@"Home_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UINavigationController *navMe = [[UINavigationController alloc] initWithRootViewController:[[NYSMeViewController alloc] init]];
    navMe.title = @"我的";
    navMe.tabBarItem.image = [[UIImage imageNamed:@"Me"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    navMe.tabBarItem.selectedImage = [[UIImage imageNamed:@"Me_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:0.75 green:0.75 blue:0.75 alpha:1.00]} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:0.20 green:0.50 blue:0.92 alpha:1.00]} forState:UIControlStateSelected];
    
    self.viewControllers = [NSArray arrayWithObjects:navHome, navMe, nil];
}

- (void)logout {
    WS(weakSelf);
    if ([UIApplication sharedApplication].keyWindow.rootViewController == self) {
        [self presentViewController:[[NYSLoginViewController alloc] init] animated:YES completion:^{
            [weakSelf clearUserinfo];
        }];
    } else {
        [self dismissViewControllerAnimated:YES completion:^{
            [weakSelf clearUserinfo];
        }];
    }
}

- (void)clearUserinfo {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault removeObjectForKey:@"account"];
    [userDefault removeObjectForKey:@"token"];
}

#pragma mark - 移除通知
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
