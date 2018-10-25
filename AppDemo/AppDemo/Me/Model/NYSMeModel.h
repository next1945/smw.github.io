//
//  NYSMeModel.h
//  AppDemo
//
//  Created by 倪刚 on 2018/10/24.
//  Copyright © 2018 NiYongsheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NYSMeModel : NSObject
/**
 cell title
 */
@property (nonatomic, copy) NSString *title;

/**
 图标
 */
@property (nonatomic, copy) NSString *icon;

/**
 通过字典来初始化模型对象
 
 @param dict 字典对象
 @return 已经完成初始化的模型对象方法
 */
- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)cellTitleWithDict:(NSDictionary *)dict;
@end
