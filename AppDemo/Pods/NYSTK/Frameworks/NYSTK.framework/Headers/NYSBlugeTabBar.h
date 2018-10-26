//
//  NYSBlugeTabBar.h
//  NYSTK
//
//  Created by 倪刚 on 2018/10/26.
//  Copyright © 2018 NiYongsheng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NYSBlugeTabBar : UITabBar
/**
 初始化一个中心凸起的TabBar
 
 Tips(TabBarViewController.m中实现下面方法):
 // #define TabBarHeight tabbarHeight + 凸起高度
 - (void)viewWillLayoutSubviews {
    CGRect tabFrame = self.tabBar.frame;
    tabFrame.size.height = TabBarHeight;
    tabFrame.origin.y = self.view.frame.size.height - TabBarHeight;
    self.tabBar.frame = tabFrame;
 }
 
 @param standOutHeight 凸起高度
 @param radius 圆弧半径
 @param strokelineWidth 描边线宽
 @param strokelineColor 描边颜色
 @param tabBarBackgroundColor tabBar背景色
 @return customTabBar
 */
- (instancetype)initWithStandOutHeight:(CGFloat)standOutHeight radius:(CGFloat)radius strokelineWidth:(CGFloat)strokelineWidth strokelineColor:(UIColor *)strokelineColor andTabBarBackgroundColor:(UIColor *)tabBarBackgroundColor;

/** tabBar高度偏移量 */
@property (assign, nonatomic) CGFloat tabBarItemY;
/** 中心tabBar高度偏移量 */
@property (assign, nonatomic) CGFloat centerTabBarItemY;

@end

NS_ASSUME_NONNULL_END
