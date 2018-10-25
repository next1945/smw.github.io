//
//  NYSChatDataSource.m
//  AppDemo
//
//  Created by 倪刚 on 2018/10/25.
//  Copyright © 2018 NiYongsheng. All rights reserved.
//

#import "NYSChatDataSource.h"

@implementation NYSChatDataSource
+ (NYSChatDataSource *)shareInstance {
    static NYSChatDataSource *instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[[self class] alloc] init];
        
    });
    return instance;
}

#pragma mark - GroupInfoFetcherDelegate

- (void)getGroupInfoWithGroupId:(NSString *)groupId completion:(void (^)(RCGroup *))completion {
    if ([groupId length] == 0)
        return;
    
    //数据请求   设置请求管理者
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 拼接请求参数
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    
    parames[@"rongGroupId"]  = groupId;// [userdefaults objectForKey:@"username"];
    
    // url
    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/im/groupDetail",POSTURL];
    NSLog(@"requestUrl = %@",requestUrl);
    [manager POST:requestUrl parameters:parames progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"请求成功JSON:%@", JSON);
        NSString * success = [NSString stringWithFormat:@"%@",JSON[@"success"]];
        if ([success isEqualToString:@"1"]) {
            NSDictionary * dic = JSON[@"returnValue"];
            if (dic != nil&&!([dic isKindOfClass:[NSNull class]])) {
                RCGroup *groupInfo = [RCGroup new];
                groupInfo.groupId = dic[@"rongGroupId"];
                groupInfo.groupName = dic[@"groupName"];
                groupInfo.portraitUri = dic[@"groupHeads"];
                completion(groupInfo);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败:%@", error.description);
    }];
}

#pragma mark - RCIMUserInfoDataSource
- (void)getUserInfoWithUserId:(NSString *)userId completion:(void (^)(RCUserInfo *))completion {
    RCUserInfo *user = [RCUserInfo new];
    if (userId == nil || [userId length] == 0) {
        user.userId = userId;
        user.portraitUri = @"";
        user.name = @"";
        completion(user);
        return;
    }
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 拼接请求参数
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    NSUserDefaults * userdefaults = [NSUserDefaults standardUserDefaults];
    parames[@"account"] = [userdefaults objectForKey:@"account"];
    parames[@"token"] = [userdefaults objectForKey:@"token"];
    parames[@"staffAccount"]  = userId;
    
    // url
    NSString *requestUrl = [NSString stringWithFormat:@"%@/api/account/getStaffInfo",POSTURL];
    NSLog(@"requestUrl = %@",requestUrl);
    [manager POST:requestUrl parameters:parames progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"请求成功JSON:%@", JSON);
        NSString * success = [NSString stringWithFormat:@"%@",JSON[@"success"]];
        if ([success isEqualToString:@"1"]) {
            NSDictionary * dic = JSON[@"returnValue"];
            if (dic != nil) {
                user.userId = dic[@"staffAccount"];
                switch ([dic[@"type"] integerValue]) {
                    case 1:
                        user.name = [NSString stringWithFormat:@"经理-%@", dic[@"trueName"]];
                        break;
                    case 2:
                        user.name = [NSString stringWithFormat:@"客服-%@", dic[@"trueName"]];
                        break;
                    case 3:
                        user.name = [NSString stringWithFormat:@"维修工-%@", dic[@"trueName"]];
                        break;
                    case 4:
                        user.name = [NSString stringWithFormat:@"保洁-%@", dic[@"trueName"]];
                        break;
                        
                    default:
                        break;
                }
                
                user.portraitUri = dic[@"imgAddress"];
                completion(user);
            }
        } else {
            NSLog(@"QMHPChatDataSource error:%@", [JSON objectForKey:@"error"]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"QMHPChatDataSource网络错误:%@", error.description);
    }];
    return;
}

@end
