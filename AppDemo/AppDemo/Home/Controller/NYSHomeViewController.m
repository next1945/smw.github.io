//
//  NYSHomeViewController.m
//  AppDemo
//
//  Created by 倪刚 on 2018/10/24.
//  Copyright © 2018 NiYongsheng. All rights reserved.
//

#import "NYSHomeViewController.h"
#import "NYSConversationViewController.h"

@interface NYSHomeViewController ()

@end

@implementation NYSHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"首页";
    if (@available(iOS 11.0, *)) {
        self.navigationController.navigationBar.prefersLargeTitles = true;
    }
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(add)];
    self.navigationItem.rightBarButtonItem = item;
    
    self.conversationListTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.conversationListTableView setSeparatorColor:[UIColor colorWithRed:0.85 green:0.84 blue:0.84 alpha:0.9]];
    
    // 设置需要显示哪些类型的会话
    [self setDisplayConversationTypes:@[
                                        @(ConversationType_PRIVATE),
                                        @(ConversationType_DISCUSSION),
                                        @(ConversationType_CHATROOM),
                                        @(ConversationType_GROUP),
                                        @(ConversationType_APPSERVICE),
                                        @(ConversationType_SYSTEM)
                                        ]];
    
    // 设置需要将哪些类型的会话在会话列表中聚合显示
    [self setCollectionConversationType:@[
                                          @(ConversationType_DISCUSSION),
                                          @(ConversationType_GROUP)
                                          ]];
    // 连接状态
    self.showConnectingStatusOnNavigatorBar = YES;
    // 会话列表头像 圆形显示
    [self setConversationAvatarStyle:RC_USER_AVATAR_CYCLE];
}

// 点击cell回调
- (void)onSelectedTableRow:(RCConversationModelType)conversationModelType
         conversationModel:(RCConversationModel *)model
               atIndexPath:(NSIndexPath *)indexPath {
    RCConversationBaseCell * cell = [self.conversationListTableView cellForRowAtIndexPath:indexPath];
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor colorWithRed:0.92 green:0.92 blue:0.92 alpha:1.00];
    cell.selectedBackgroundView = view;
    
    NYSConversationViewController *conversationVC = [[NYSConversationViewController alloc] init];
    conversationVC.conversationType = model.conversationType;
    conversationVC.targetId = model.targetId;
    conversationVC.title = model.conversationTitle;
    [self.navigationController pushViewController:conversationVC animated:YES];
}

- (void)willDisplayConversationTableCell:(RCConversationBaseCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    //    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    cell.selectedBackgroundView = view;
}

- (void)add {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
