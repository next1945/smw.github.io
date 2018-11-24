//
//  NYSTabViewController.m
//  AppDemo
//
//  Created by 倪刚 on 2018/10/24.
//  Copyright © 2018 NiYongsheng. All rights reserved.
//

#import "NYSTabViewController.h"
#import "NYSHomeViewController.h"
#import "NYSPagesViewController.h"
#import "NYSMeViewController.h"
#import "NYSLoginViewController.h"

#define StandOutHeight 17

@interface NYSTabViewController ()

@end

@implementation NYSTabViewController

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];

    CGRect tabFrame = self.tabBar.frame;
    tabFrame.size.height = 49 + StandOutHeight;
    tabFrame.origin.y = self.view.frame.size.height - (49 + StandOutHeight);
    self.tabBar.frame = tabFrame;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(logout) name:@"LogoutNotification" object:nil];
    
    // KVC替换tabbar
    NYSBlugeTabBar *myTabBar = [[NYSBlugeTabBar alloc] initWithStandOutHeight:StandOutHeight radius:27 strokelineWidth:0.7 strokelineColor:[UIColor colorWithWhite:0.765 alpha:1.000] andTabBarBackgroundColor:[UIColor whiteColor]];
    myTabBar.tabBarItemY = 10;
    myTabBar.centerTabBarItemY = 0;
    myTabBar.alpha = 0.95;
    [self setValue:myTabBar forKey:@"tabBar"];
    
    // 首页
    UINavigationController *navHome = [[UINavigationController alloc] initWithRootViewController:[[NYSHomeViewController alloc] init]];
    navHome.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"首页" image:[[UIImage imageNamed:@"Home"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"Home_selected"]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    // 凸起
    NYSPagesViewController *pagesVc = [[NYSPagesViewController alloc] init];
    UINavigationController *navPop = [[UINavigationController alloc] initWithRootViewController:pagesVc];
    navPop.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"GitHub" image:[[UIImage imageNamed:@"github"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"githubHilight"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    // 我的
    UINavigationController *navMe = [[UINavigationController alloc] initWithRootViewController:[[NYSMeViewController alloc] init]];
    navMe.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我的" image:[[UIImage imageNamed:@"Me"]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"Me_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];

    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:0.75 green:0.75 blue:0.75 alpha:1.00]} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:0.20 green:0.50 blue:0.92 alpha:1.00]} forState:UIControlStateSelected];
    
    self.viewControllers = [NSArray arrayWithObjects:navHome, navPop, navMe, nil];
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

/** 清除缓存 */
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
