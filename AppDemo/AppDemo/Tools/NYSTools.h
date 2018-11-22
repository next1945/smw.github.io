//
//  NYSTools.h
//  AppDemo
//
//  Created by 倪永胜 on 2018/11/22.
//  Copyright © 2018 NiYongsheng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NYSTools : NSObject

/**
 滚动动画
 
 @param duration 滚动显示
 @param layer 作用图层
 */
+ (void)animateTextChange:(CFTimeInterval)duration withLayer:(CALayer *)layer;

/**
 弹性缩放动画
 
 @param button 作用按钮
 */
+ (void)zoomToShow:(UIButton *)button;

/**
 左右晃动动画
 
 @param button 作用按钮
 */
+ (void)swayToShow:(UIButton *)button;

/**
 左右抖动动画（错误提醒）
 
 @param button 作用按钮
 */
+ (void)shakToShow:(UIButton *)button;

/**
 左右抖动动画（错误提醒）
 
 @param layer 左右图层
 */
+ (void)shakeAnimationWithLayer:(CALayer *)layer;

@end

NS_ASSUME_NONNULL_END
