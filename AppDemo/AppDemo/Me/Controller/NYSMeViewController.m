//
//  NYSMeViewController.m
//  AppDemo
//
//  Created by 倪刚 on 2018/10/24.
//  Copyright © 2018 NiYongsheng. All rights reserved.
//

#import "NYSMeViewController.h"
#import "NYSTabViewController.h"
#import <WXWaveView.h>
#import "NYSMeModel.h"
#import "NYSMeTableViewCell.h"

#import "NYSDosign.h"

#import <UIImageView+WebCache.h>
#import <CoreMotion/CoreMotion.h>
#import <UShareUI/UShareUI.h>

#import "NYSAboutViewController.h"

@interface NYSMeViewController () <UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate, UMSocialShareMenuViewDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftWhiteLine;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightWhiteLine;
@property (weak, nonatomic) IBOutlet UIView *sportView;
@property (weak, nonatomic) IBOutlet UIView *pointView;
@property (weak, nonatomic) IBOutlet UIView *stepView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *iconWith;
@property (weak, nonatomic) IBOutlet UIButton *icon;
/** 约束状态栏高度偏移量 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutStatusHeight;
/** 个人信息设置 */
- (IBAction)iconButtonClicked:(id)sender;
- (IBAction)Logout:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (strong, nonatomic) WXWaveView *waveView;
// 模型数组
@property (strong, nonatomic) NSMutableArray *modelMArray;
// 头像
@property (weak, nonatomic) IBOutlet UIButton *headIcon;
// 昵称
@property (weak, nonatomic) IBOutlet UILabel *nikeName;
// 日均步数
@property (weak, nonatomic) IBOutlet UILabel *averageStepNum;
// 我的积分
@property (weak, nonatomic) IBOutlet UILabel *score;
// 签到天数
@property (weak, nonatomic) IBOutlet UILabel *signDays;

@property (nonatomic, strong) CMPedometer *pedometer;

@property (assign, nonatomic) NSInteger scoreCount;
@property (assign, nonatomic) NSInteger signDayCount;
@end

@implementation NYSMeViewController

- (NSMutableArray *)modelMArray
{
    if (_modelMArray == nil)
    {
        NSArray *dictArray =  [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"me.plist" ofType:nil]];
        NSMutableArray *modelArray = [NSMutableArray array];
        
        for (NSDictionary *dict in dictArray)
        {
            NYSMeModel *model = [NYSMeModel cellTitleWithDict:dict];  //把字典转换为模型对象
            [modelArray addObject:model];
        }
        _modelMArray = modelArray;
    }
    return _modelMArray;
}

/** 视图即将可见时 */
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // 设置导航控制器的代理为self
    self.navigationController.delegate = self;
}

/** 视图已完全过渡到屏幕上 */
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 约束状态栏高度偏移量
    _layoutStatusHeight.constant = -getRectStatusHight;
    
    // 间隔竖线位置约束
    if (ScreenWidth == 320) {
        _leftWhiteLine.constant = (CGRectGetMinX(_pointView.frame) - CGRectGetMaxX(_sportView.frame)) * 0.5 + CGRectGetMaxX(_sportView.frame) - 15;
        _rightWhiteLine.constant = _leftWhiteLine.constant;
    } else {
        _leftWhiteLine.constant = (CGRectGetMinX(_pointView.frame) - CGRectGetMaxX(_sportView.frame)) * 0.5 + CGRectGetMaxX(_sportView.frame);
        _rightWhiteLine.constant = _leftWhiteLine.constant;
    }
    
    
    _tableView.backgroundColor = RGBColor(245, 245, 245);
    [[UITableViewHeaderFooterView appearance] setTintColor:RGBColor(245, 245, 245)];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.iconWith.constant = 75 * ScreenWidth/375;
    self.icon.layer.cornerRadius = self.iconWith.constant * 0.5;
    self.icon.layer.masksToBounds = YES;

    self.tableView.tableHeaderView = _headerView;
    
    
    // 2、友盟分享
    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_WechatSession),
                                               @(UMSocialPlatformType_WechatTimeLine),
                                               @(UMSocialPlatformType_WechatFavorite),
                                               @(UMSocialPlatformType_QQ),
                                               @(UMSocialPlatformType_Qzone)
                                               ]];
    // 设置分享面板的显示和隐藏的代理回调
    [UMSocialUIManager setShareMenuViewDelegate:self];
    
    [self.sportView setUserInteractionEnabled:YES];
    UITapGestureRecognizer *tapGesturRecognizer1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction1)];
    [self.sportView addGestureRecognizer:tapGesturRecognizer1];
    
    [self.pointView setUserInteractionEnabled:YES];
    UITapGestureRecognizer *tapGesturRecognizer2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction2)];
    [self.pointView addGestureRecognizer:tapGesturRecognizer2];
    
    [self.stepView setUserInteractionEnabled:YES];
    UITapGestureRecognizer *tapGesturRecognizer3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction3)];
    [self.stepView addGestureRecognizer:tapGesturRecognizer3];
}

- (void)tapAction1 {

}

- (void)tapAction2 {

}

- (void)tapAction3 {

}

/** 设置状态栏颜色样式 */
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

// 水波纹
- (void)viewDidLayoutSubviews {
    if (!self.waveView) {
        // Initialization
        self.waveView = [WXWaveView addToView:self.tableView.tableHeaderView withFrame:CGRectMake(0, CGRectGetHeight(self.tableView.tableHeaderView.frame) - 4.5, CGRectGetWidth(self.tableView.frame), 5)];
        
        // Optional Setting
        self.waveView.waveTime = 2.f;
//        self.waveView.waveColor = [UIColor whiteColor];
        self.waveView.waveSpeed = 15.f; // 波速度
        self.waveView.angularSpeed = 2.0f; // 角速度
    }
}

#pragma mark - UIScrollView
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    WS(weakSelf);
    if ([self.waveView wave]) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [self.waveView stop];
            [weakSelf getStepsAndDistance];
            [NYSTools animateTextChange:1.f withLayer:weakSelf.score.layer];
            weakSelf.score.text = [NSString stringWithFormat:@"%ld", weakSelf.scoreCount];
            [NYSTools animateTextChange:1.f withLayer:weakSelf.signDays.layer];
            weakSelf.signDays.text = [NSString stringWithFormat:@"%ld", weakSelf.signDayCount];
        });
    }
}

/** 读取当前步数距离信息 */
- (void)getStepsAndDistance {
    _pedometer = [[CMPedometer alloc] init];
    if ([CMPedometer isStepCountingAvailable]) {
        // 获取昨天的步数与距离数据
        [_pedometer queryPedometerDataFromDate:[self zeroOfDate] toDate:[NSDate dateWithTimeIntervalSinceNow:0] withHandler:^(CMPedometerData * _Nullable pedometerData, NSError * _Nullable error) {
            if (error) {
                NSLog(@"计步器error===%@",error);
                [SVProgressHUD showErrorWithStatus:[error description]];
                [SVProgressHUD dismissWithDelay:1.0f];
            } else {
                NSLog(@"步数===%@",pedometerData.numberOfSteps);
                NSLog(@"距离===%@",pedometerData.distance);
                dispatch_async(dispatch_get_main_queue(), ^{
                    // 当前步数
                    [NYSTools animateTextChange:1.f withLayer:self.averageStepNum.layer];
                    self.averageStepNum.text = [NSString stringWithFormat:@"%.02fkm", [pedometerData.distance floatValue] * 0.001];
                });
            }
        }];
    } else {
        NSLog(@"计步器不可用===");
        [SVProgressHUD showErrorWithStatus:@"计步器不可用"];
        [SVProgressHUD dismissWithDelay:1.f];
    }
}

/** 获取0点钟NSDate */
- (NSDate *)zeroOfDate {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSUIntegerMax fromDate:[NSDate date]];
    components.hour = 0;
    components.minute = 0;
    components.second = 0;
    
    // components.nanosecond = 0 not available in iOS
    NSTimeInterval ts = (double)(int)[[calendar dateFromComponents:components] timeIntervalSince1970];
    return [NSDate dateWithTimeIntervalSince1970:ts];
}

/** 滑动等比例拉伸header */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    // 获取到tableView偏移量
    CGFloat Offset_y = scrollView.contentOffset.y;
    // 下拉 纵向偏移量变小 变成负的
    if ( Offset_y < 0) {
        CGRect rect = self.headerImageView.frame;
        //我们只需要改变图片的y值和高度即可
        rect.origin.y = Offset_y;
        rect.size.width = ScreenWidth - Offset_y;
        rect.size.height = _tableView.tableHeaderView.frame.size.height - Offset_y;
        _headerImageView.frame = rect;
    } else {

    }
}

#pragma mark - UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 3;
    } else if (section == 1) {
        return 3;
    } else if (section == 2) {
        return 2;
    }
    return 0;
}

/** tableView Section count */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

/** Section头部间隔高度 */
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CellSpacing;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 1.创建自定义的cell
    NYSMeTableViewCell *cell = [NYSMeTableViewCell cellWithTableView:tableView];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    // 2.传递模型数据
    if (indexPath.section == 0) {
        cell.meCellModel = self.modelMArray[indexPath.row + indexPath.section * 3];
    } else if (indexPath.section == 1) {
        cell.meCellModel = self.modelMArray[indexPath.row + indexPath.section * 3];
    } else {
        cell.meCellModel = self.modelMArray[indexPath.row + 6];
    }
    
    return cell;
}

/** 设置section整体圆角 */
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(tintColor)]) {
        
        if (tableView == self.tableView) {
            // 圆角尺寸
            CGFloat cornerRadius = 10.f;
            
            cell.backgroundColor = UIColor.clearColor;
            CAShapeLayer *layer = [[CAShapeLayer alloc] init];
            CGMutablePathRef pathRef = CGPathCreateMutable();
            CGRect bounds = CGRectInset(cell.bounds, 10, 0);
            BOOL addLine = NO;
            
            if (indexPath.row == 0 && indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1) {
                CGPathAddRoundedRect(pathRef, nil, bounds, cornerRadius, cornerRadius);
            } else if (indexPath.row == 0) { // 分组首行
                CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds));
                CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds), CGRectGetMidX(bounds), CGRectGetMinY(bounds), cornerRadius);
                CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
                CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds));
                addLine = YES;
            } else if (indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1) { // 分组末行
                CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds));
                CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds), CGRectGetMidX(bounds), CGRectGetMaxY(bounds), cornerRadius);
                CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
                CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds));
            } else {
                CGPathAddRect(pathRef, nil, bounds);
                addLine = YES;
            }
            
            layer.path = pathRef;
            CFRelease(pathRef);
            layer.fillColor = [UIColor colorWithWhite:1.f alpha:0.8f].CGColor;
            
            if (addLine == YES) {
                CALayer *lineLayer = [[CALayer alloc] init];
                CGFloat lineHeight = (1.f / [UIScreen mainScreen].scale);
                lineLayer.frame = CGRectMake(CGRectGetMinX(bounds)+10, bounds.size.height-lineHeight, bounds.size.width-10, lineHeight);
                lineLayer.backgroundColor = tableView.separatorColor.CGColor;
                [layer addSublayer:lineLayer];
            }
            UIView *testView = [[UIView alloc] initWithFrame:bounds];
            [testView.layer insertSublayer:layer atIndex:0];
            testView.backgroundColor = UIColor.clearColor;
            cell.backgroundView = testView;
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES]; // 取消选中
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0: {
                NYSDosign *dosignSucess = [[NYSDosign alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
                [self.view addSubview:dosignSucess];
                self.scoreCount += 10;
                self.signDayCount ++;
            }
                break;
                
            default:
                break;
        }
    } else if (indexPath.section == 1) {
        
    } else {
        switch (indexPath.row) {
            case 0: {
                [UMSocialUIManager removeAllCustomPlatformWithoutFilted];
                [UMSocialShareUIConfig shareInstance].sharePageGroupViewConfig.sharePageGroupViewPostionType = UMSocialSharePageGroupViewPositionType_Bottom;
                [UMSocialShareUIConfig shareInstance].sharePageScrollViewConfig.shareScrollViewPageItemStyleType = UMSocialPlatformItemViewBackgroudType_IconAndBGRadius;
                WS(weakSelf);
                [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
                    // 根据获取的platformType确定所选平台进行下一步操作
                    switch (platformType) {
                        case UMSocialPlatformType_WechatSession:
                            [weakSelf shareWebPageToPlatformType:UMSocialPlatformType_WechatSession];
                            break;
                        case UMSocialPlatformType_WechatTimeLine:
                            [weakSelf shareWebPageToPlatformType:UMSocialPlatformType_WechatTimeLine];
                            break;
                        case UMSocialPlatformType_WechatFavorite:
                            [weakSelf shareWebPageToPlatformType:UMSocialPlatformType_WechatFavorite];
                            break;
                        case UMSocialPlatformType_QQ:
                            [weakSelf shareWebPageToPlatformType:UMSocialPlatformType_QQ];
                            break;
                        case UMSocialPlatformType_Qzone:
                            [weakSelf shareWebPageToPlatformType:UMSocialPlatformType_Qzone];
                            break;
                            
                        default:
                            break;
                    }
                }];
            }
                break;
            case 1: {
                NYSAboutViewController *aboutVC = [[NYSAboutViewController alloc] init];
                aboutVC.hidesBottomBarWhenPushed = YES;
                aboutVC.title = @"关于";
                [self.navigationController pushViewController:aboutVC animated:YES];
            }
                break;
                
            default:
                break;
        }
    }
}


#pragma mark - 个人信息设置
- (IBAction)iconButtonClicked:(id)sender {
    
}

/** 登出 */
- (IBAction)Logout:(id)sender {
    [NYSTools zoomToShow:sender];
    [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"LogoutNotification" object:nil userInfo:nil]];
}

#pragma mark - UINavigationControllerDelegate
// 将要显示控制器
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    NSLog(@"isShowHomePage:%@", isShowHomePage ? @"YES" : @"NO");
    [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];
}


#pragma mark - UM友盟分享
// 网页分享 @"http://p8ppgb8ha.bkt.clouddn.com/anjugongshe.png"
- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType {
    [self shareWebPageToPlatformType:platformType withTitle:@"AppDemo" descr:@"Quickly Create An App." url:AppStoreURL thumb:[UIImage imageNamed:@"icon-1024"]];
}

- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType withTitle:(NSString *)title descr:(NSString *)descr url:(NSString *)url thumb:(id)thumb {
    // 创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    // 创建网页内容对象
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:title descr:descr thumImage:thumb];
    
    // 设置网页地址
    shareObject.webpageUrl = url;
    
    // 分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    // 调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        
        if (error) {
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
        } else {
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                // 分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                // 第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                
            } else {
                UMSocialLogInfo(@"response data is %@",data);
            }
        }
        [self alertWithError:error];
    }];
}

- (void)alertWithError:(NSError *)error {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    if (!error) {
        [self shareResult:^(NSString *result) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享结果"
                                                            message:result
                                                           delegate:nil
                                                  cancelButtonTitle:@"好的"
                                                  otherButtonTitles:nil];
            [alert show];
        }];
    } else {
        NSString *result = nil;
        NSMutableString *str = [NSMutableString string];
        if (error.userInfo) {
            for (NSString *key in error.userInfo) {
                [str appendFormat:@"%@ = %@\n", key, error.userInfo[key]];
            }
        }
        result = [NSString stringWithFormat:@"\n分享失败:%@", str];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享结果"
                                                        message:result
                                                       delegate:nil
                                              cancelButtonTitle:@"好的"
                                              otherButtonTitles:nil];
        [alert show];
    }
#pragma clang diagnostic pop
}

/** 获取分享结果 */
- (void)shareResult:(void (^) (NSString *result))completion{
    // 1、创建请求管理对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 2、发送请求URL
    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/share/doShare", POSTURL];
    NSLog(@"requestUrl = %@",requestUrl);
    
    NSUserDefaults * userdefaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"account"] = [userdefaults objectForKey:@"account"];
    parames[@"token"] = [userdefaults objectForKey:@"token"];
    parames[@"comNo"] = [userdefaults objectForKey:@"comNo"];
    NSLog(@"parames:%@", parames);
    
    [manager POST:requestUrl parameters:parames progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"返回数据%@",responseObject);
        NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"请求成功JSON:%@", JSON);
        if ([[JSON objectForKey:@"success"] integerValue] == 1) {
            NSLog(@"验证成功");
            completion([JSON objectForKey:@"msg"]);
        } else {
            completion([JSON objectForKey:@"error"]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败:%@", error.description);
        completion(@"ERROR");
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
