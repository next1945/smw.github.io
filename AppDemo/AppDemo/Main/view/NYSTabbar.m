//
//  NYSTabbar.m
//  AppDemo
//
//  Created by 倪刚 on 2018/10/25.
//  Copyright © 2018 NiYongsheng. All rights reserved.
//

#import "NYSTabbar.h"

@implementation NYSTabbar

- (void)drawRect:(CGRect)rect {
    //1.获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //2.描述路径
    UIBezierPath *path = [[UIBezierPath alloc] init];
    CGFloat with = rect.size.width;
    CGFloat height = rect.size.height;
    //    [path moveToPoint:CGPointMake(0, 5)];
    //    [path addLineToPoint:CGPointMake(10, 5)];
    //    [path addLineToPoint:CGPointMake(15, 0)];
    //    [path addLineToPoint:CGPointMake(20, 5)];
    //    [path addLineToPoint:CGPointMake(with, 5)];
    //
    //    [path addLineToPoint:CGPointMake(with, height)];
    //    [path addLineToPoint:CGPointMake(0, height)];
    //    [path closePath];
    
    [path moveToPoint:CGPointMake(0, height)];
    [path addLineToPoint:CGPointMake(with * 0.5, 0)];
    [path addLineToPoint:CGPointMake(with, height)];
    [path closePath];
    
    //    [path fill];
    
    //3.把路径添加到上下文
    CGContextAddPath(ctx, path.CGPath);
    [[UIColor redColor] set]; // 路径的颜色
    
    //4.把上下文的内容渲染到View的layer.
    //    CGContextStrokePath(ctx); // 描边路径
    CGContextFillPath(ctx); // 填充路径
}

@end
