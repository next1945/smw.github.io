//
//  NYSMyWebPageViewController.m
//  AppDemo
//
//  Created by 倪永胜 on 2018/11/24.
//  Copyright © 2018 NiYongsheng. All rights reserved.
//

#import "NYSMyWebPageViewController.h"
#import <WebKit/WebKit.h>

@interface NYSMyWebPageViewController () <WKNavigationDelegate>
@property (strong, nonatomic) WKWebView *webView;
@property (weak, nonatomic) CALayer *progresslayer;
@end

@implementation NYSMyWebPageViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie *cookie in [cookieJar cookies]) {
        NSLog(@"查看cookies:%@", cookie);
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *item0 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(sharePage)];
    self.navigationItem.rightBarButtonItem = item0;
    
//    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(rightBarButton)];
//    self.navigationItem.rightBarButtonItem = item;
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.webView];
    
    // 左右滑动
    UIScreenEdgePanGestureRecognizer *gobackRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(backOff)];
    gobackRecognizer.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:gobackRecognizer];
    
    UIScreenEdgePanGestureRecognizer *goforwardRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(forward)];
    goforwardRecognizer.edges = UIRectEdgeRight;
    [self.view addGestureRecognizer:goforwardRecognizer];
    
    // 进度条
    CGFloat progressHeight = self.navigationController.navigationBar.frame.size.height + [[UIApplication sharedApplication] statusBarFrame].size.height;
    UIView *progress = [[UIView alloc]initWithFrame:CGRectMake(0, progressHeight, CGRectGetWidth(self.view.frame), 3)];
    progress.backgroundColor = [UIColor clearColor];
    [self.view addSubview:progress];
    
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(0, 0, 0, 3);
    layer.backgroundColor = [UIColor colorWithRed:0.29 green:0.57 blue:0.92 alpha:1.00].CGColor;
    [progress.layer addSublayer:layer];
    self.progresslayer = layer;
    
    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSArray *_tmpArray = [NSArray arrayWithArray:[cookieJar cookies]];
    for (id obj in _tmpArray) {
        [cookieJar deleteCookie:obj];
    }
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_url] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:5.0];
    [self.webView loadRequest:request];
}

- (void)backOff {
    NSLog(@"backOff");
    if (self.webView.canGoBack) {
        [self.webView goBack];
    }
}

- (void)forward {
    NSLog(@"forward");
    if (self.webView.canGoForward) {
        [self.webView goForward];
    }
}

- (WKWebView *)webView {
    if (!_webView) {
        WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:@"" injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:NO];
        WKUserContentController *wkUController = [[WKUserContentController alloc] init];
        [wkUController addUserScript:wkUScript];
        WKWebViewConfiguration *wkWebConfig = [[WKWebViewConfiguration alloc] init];
        wkWebConfig.userContentController = wkUController;
        _webView=[[WKWebView alloc] initWithFrame:CGRectMake(0, getRectNavHight + getRectStatusHight, ScreenWidth, ScreenHeight - (getRectNavHight + getRectStatusHight)) configuration:wkWebConfig];
        _webView.navigationDelegate = self;
        [_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
        if ([self.webView.scrollView respondsToSelector:@selector(setContentInsetAdjustmentBehavior:)]) {
            if (@available(iOS 11.0, *)) {
                self.webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            } else {
            }
        }
    }
    return _webView;
}

- (void)rightBarButton {
    [self.webView reload];
}

- (void)sharePage {
    NSArray *images = @[_url];
    UIActivityViewController *activityController=[[UIActivityViewController alloc]initWithActivityItems:images applicationActivities:nil];
    [self.navigationController presentViewController:activityController animated:YES completion:nil];
}

// KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        NSLog(@"%@", change);
        self.progresslayer.opacity = 1;
        self.progresslayer.frame = CGRectMake(0, 0, self.view.bounds.size.width * [change[NSKeyValueChangeNewKey] floatValue], 3);
        if ([change[NSKeyValueChangeNewKey] floatValue] == 1) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.progresslayer.opacity = 0;
            });
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.progresslayer.frame = CGRectMake(0, 0, 0, 3);
            });
        }
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)dealloc{
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
