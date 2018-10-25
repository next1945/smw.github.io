//
//  NYSChatDataSource.h
//  AppDemo
//
//  Created by 倪刚 on 2018/10/25.
//  Copyright © 2018 NiYongsheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RongIMKit/RongIMKit.h>

#define RCDDataSource [RCDRCIMDataSource shareInstance]

NS_ASSUME_NONNULL_BEGIN

@interface NYSChatDataSource : NSObject <RCIMUserInfoDataSource, RCIMGroupInfoDataSource>
+ (NYSChatDataSource *)shareInstance;
@end

NS_ASSUME_NONNULL_END
