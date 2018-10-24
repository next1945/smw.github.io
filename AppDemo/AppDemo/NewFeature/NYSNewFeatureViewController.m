//
//  NYSNewFeatureViewController.m
//  AppDemo
//
//  Created by 倪刚 on 2018/10/24.
//  Copyright © 2018 NiYongsheng. All rights reserved.
//

#import "NYSNewFeatureViewController.h"
#import "NYSTabViewController.h"
#import "NYSLoginViewController.h"

#define NewfeatureImageCount 4

@interface NYSNewFeatureViewController ()
@property (nonatomic, weak) UIPageControl *pageControl;
@end

@implementation NYSNewFeatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 0.添加一个背景
    //    UIImageView *bg = [[UIImageView alloc] init];
    //    bg.image = [UIImage imageWithName:@"new_feature_background"];
    //    bg.frame = self.view.bounds;
    //    [self.view addSubview:bg];
    self.view.backgroundColor = RGBColor(246, 246, 246);
    
    // 1.添加UIScrollView
    [self setupScrollView];
    
    // 2.添加pageControll
    [self setupPagecontrol];
}

/** 设置状态栏颜色样式 */
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

/** 添加pageControll */
- (void)setupPagecontrol
{
    // 1.添加pageControl
    UIPageControl *pagecontrol = [[UIPageControl alloc] init];
    pagecontrol.numberOfPages = NewfeatureImageCount;
    pagecontrol.center = CGPointMake(self.view.frame.size.width * 0.5, self.view.frame.size.height * 0.95);
    pagecontrol.bounds = CGRectMake(0, 0, 200, 50);
    pagecontrol.userInteractionEnabled = NO;
    [self.view addSubview:pagecontrol];
    
    // 2.设置圆点颜色
    pagecontrol.currentPageIndicatorTintColor = [UIColor whiteColor];
    pagecontrol.pageIndicatorTintColor = RGBColor(147, 204, 247);
    
    self.pageControl = pagecontrol;
}

/** 添加UIScrollView */
- (void)setupScrollView
{
    // 1.添加scrollView
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.bounds;
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    
    // 2.添加图片
    CGFloat imageW = scrollView.frame.size.width;
    CGFloat imageH = scrollView.frame.size.height;
    for (int index = 0; index < NewfeatureImageCount; index ++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        
        // 设置图片
        NSString *name = [NSString stringWithFormat:@"new_feature_%d", index + 1];
        imageView.image = [UIImage imageNamed:name];
        
        // 设置frame
        CGFloat imageX = index * imageW;
        imageView.frame = CGRectMake(imageX, 0, imageW, imageH);
        
        [scrollView addSubview:imageView];
        
        // 在最后一页上添加按钮
        if (index == NewfeatureImageCount - 1) {
            [self setupLastImageView:imageView];
        }
    }
    
    // 3.设置滚动的内容尺寸
    scrollView.contentSize = CGSizeMake(imageW * NewfeatureImageCount, 0);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    //    scrollView.bounces = NO;
}

/** 添加按钮到最后一页 */
- (void)setupLastImageView:(UIImageView *)imageView
{
    // 0.让imageView能跟用户交互
    imageView.userInteractionEnabled = YES;
    
    // 1.添加开始按钮
    UIButton *startButton = [[UIButton alloc] init];
    [startButton setBackgroundImage:[UIImage imageNamed:@"新特性按钮"] forState:UIControlStateNormal];
    //    [startButton setBackgroundImage:[UIImage imageWithName:@"new_feature_finish_button_highlighted"] forState:UIControlStateNormal];
    // 2.设置frame
    startButton.center = CGPointMake(imageView.frame.size.width * 0.5, imageView.frame.size.height * 0.82);
    startButton.bounds = (CGRect){CGPointZero, startButton.currentBackgroundImage.size};
    // 3.设置文字
    //    [startButton setTitle:@"开启新体验" forState:UIControlStateNormal];
    //    [startButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [startButton addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:startButton];
}

/** 开始微博 */
- (void)start
{
    // 判断是否存在access token
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    NSString *account = [userdefaults objectForKey:@"account"];
    NSString *token = [userdefaults objectForKey:@"token"];
    if (account && token) { // 之前登录成功
        [UIApplication sharedApplication].keyWindow.rootViewController = [[NYSTabViewController alloc] init];
    } else { // 之前没有登录成功
        [UIApplication sharedApplication].keyWindow.rootViewController = [[NYSLoginViewController alloc] init];
    }
}

/** 判断是否选中 */
- (void)checkboxClick:(UIButton *)checkbox
{
    checkbox.selected = !checkbox.isSelected;
}


/** 实现scrollView的代理方法（只要UIScrollView滚动时就调用此方法） */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 1.取出水平方向上滚动的距离
    CGFloat offsetX = scrollView.contentOffset.x;
    
    // 2.求出页码
    double pageDouble = offsetX / scrollView.frame.size.width;
    int pageInt = (int)(pageDouble + 0.5);
    self.pageControl.currentPage = pageInt;
}


@end
