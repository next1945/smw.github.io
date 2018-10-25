//
//  NYSConversationViewController.m
//  AppDemo
//
//  Created by 倪刚 on 2018/10/25.
//  Copyright © 2018 NiYongsheng. All rights reserved.
//

#import "NYSConversationViewController.h"

@interface NYSConversationViewController ()

@end

@implementation NYSConversationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 移除红包功能
    [self.pluginBoardView removeItemWithTag:PLUGIN_BOARD_ITEM_RED_PACKET_TAG];
    [self setMessageAvatarStyle:RC_USER_AVATAR_CYCLE];
}

@end
