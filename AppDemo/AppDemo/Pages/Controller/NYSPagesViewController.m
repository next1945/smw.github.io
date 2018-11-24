//
//  NYSPagesViewController.m
//  安居公社
//
//  Created by 倪刚 on 2018/3/5.
//  Copyright © 2018年 QingMai. All rights reserved.
//

#import "NYSPagesViewController.h"
#import <WebKit/WebKit.h>

// 定义一个JS代码的宏
#define POST_JS @"function my_post(path, params) {\
var method = \"POST\";\
var form = document.createElement(\"form\");\
form.setAttribute(\"method\", method);\
form.setAttribute(\"action\", path);\
for(var key in params){\
if (params.hasOwnProperty(key)) {\
var hiddenFild = document.createElement(\"input\");\
hiddenFild.setAttribute(\"type\", \"hidden\");\
hiddenFild.setAttribute(\"name\", key);\
hiddenFild.setAttribute(\"value\", params[key]);\
}\
form.appendChild(hiddenFild);\
}\
document.body.appendChild(form);\
form.submit();\
}"

#define StandOutHeight 17

@interface NYSPagesViewController () <WKNavigationDelegate>
@property (strong, nonatomic) WKWebView *webView;
@property (weak, nonatomic) CALayer *progresslayer;
@end

@implementation NYSPagesViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie *cookie in [cookieJar cookies]) {
        NSLog(@"查看cookies:%@", cookie);
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"GitHub";
    
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 32, 32)];
    UIButton *lbtn = [[UIButton alloc] initWithFrame:contentView.bounds];
    [lbtn setBackgroundImage:[UIImage imageNamed:@"safari"] forState:UIControlStateNormal];
    [contentView addSubview:lbtn];
    [lbtn addTarget:self action:@selector(leftBarButton) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:contentView];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(rightBarButton)];
    self.navigationItem.rightBarButtonItem = item;
    
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
    
    NSURLRequest *request = [NSURLRequest requestWithURL:GITHUB_URL cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:5.0];
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
        _webView=[[WKWebView alloc] initWithFrame:CGRectMake(0, getRectNavHight + getRectStatusHight, ScreenWidth, ScreenHeight - (getRectNavHight + getRectStatusHight + self.tabBarController.tabBar.bounds.size.height) + StandOutHeight) configuration:wkWebConfig];
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
    NSURLRequest *request = [NSURLRequest requestWithURL:GITHUB_URL cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:5.0];
    [self.webView loadRequest:request];
//    [self.webView reload];
}

- (void)leftBarButton {
    UIApplication *application = [UIApplication sharedApplication];
    if (@available(iOS 10.0, *)) {
        [application openURL:GITHUB_URL options:@{} completionHandler:^(BOOL success) {
            NSLog(@"Open %@: %d",[GITHUB_URL absoluteString],success);
        }];
    } else {
        BOOL success = [application openURL:GITHUB_URL];
        NSLog(@"Open %@: %d",[GITHUB_URL absoluteString],success);
    }
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
