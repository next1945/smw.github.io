//
//  NSNumber+NTK.h
//  NYSToolKit
//
//  Created by 倪刚 on 2018/10/22.
//  Copyright © 2018 NiYongsheng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSNumber (NTK)

/**
 把字符串解析为NSNumber。(如解析失败则返回nil)
 
 支持各种格式，例如 @"12", @"12.345", @" -0xFF", @" .23e99 "
 不区分大小写，可以有空格
 */
+ (NSNumber *)numberWithString:(NSString *)string;

/**
 如果超出9999，则折叠成 XX.X 万
 */
- (NSString *)wrappedDescription;

- (NSString *)toDecimalStyleString;

@end

NS_ASSUME_NONNULL_END
