//
//  NYSDosign.m
//  AppDemo
//
//  Created by 倪刚 on 2018/10/27.
//  Copyright © 2018 NiYongsheng. All rights reserved.
//

#import "NYSDosign.h"

@implementation NYSDosign

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        // 半透明遮罩
        UIBlurEffect * blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        UIVisualEffectView * effectView = [[UIVisualEffectView alloc]initWithEffect:blur];
        effectView.frame = frame;
        
        UIImageView *doSignImageView = [[UIImageView alloc] init];
        [doSignImageView setImage:[UIImage imageNamed:@"签到成功"]];
        doSignImageView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        
        [effectView.contentView addSubview:doSignImageView];
        [self addSubview:effectView];
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self removeFromSuperview];
}

@end
