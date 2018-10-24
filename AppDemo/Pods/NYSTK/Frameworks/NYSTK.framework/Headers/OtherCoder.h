//
//  OtherCoder.h
//  NYSToolKit
//
//  Created by 倪刚 on 2018/10/22.
//  Copyright © 2018 NiYongsheng. All rights reserved.
//

#pragma mark - 通知
/*
 // 发送通知
 NSDictionary *dict = @{@"codeContent":str};
 [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"scanResultNotification" object:nil userInfo:dict]];
 
 // 监听通知
 NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
 [center addObserver:self selector:@selector(codeContentList:) name:@"scanResultNotification" object:nil];
 
 // 实现监听方法
 - (void)setStatusListType:(NSNotification *)notification{
 NSDictionary * infoDic = [notification userInfo];
 }
 
 #pragma mark - 移除通知
 - (void)dealloc {
 [[NSNotificationCenter defaultCenter] removeObserver:self];
 }
 */



// 导航栏常用设置方法
/*
 // 0.全局导航栏样式设置
 [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
 // 隐藏返回文字（！返回会按钮向下偏移）
 //    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
 // 自定义返回按钮图片
 [[UIBarButtonItem appearance] setBackButtonBackgroundImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal barMetrics:UIBarMetricsCompactPrompt];
 // 导航栏背景
 [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
 // 将返回，左，右 item的字体颜色设置为白色
 [[UINavigationBar appearance] setTintColor:NavigationColor];
 */
