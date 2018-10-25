//
//  NYSMeModel.m
//  AppDemo
//
//  Created by 倪刚 on 2018/10/24.
//  Copyright © 2018 NiYongsheng. All rights reserved.
//

#import "NYSMeModel.h"

@implementation NYSMeModel
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.title = dict[@"title"];
        self.icon = dict[@"icon"];
    }
    
    return self;
}

+ (instancetype)cellTitleWithDict:(NSDictionary *)dict
{
    return [[NYSMeModel alloc] initWithDict:dict];
}
@end
