//
//  NSCharacterSet+NTK.h
//  NYSToolKit
//
//  Created by 倪刚 on 2018/10/22.
//  Copyright © 2018 NiYongsheng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSCharacterSet (NTK)

/**
 Returns a character set containing all Apple Emoji.
 */
+ (NSCharacterSet *)emojiCharacterSet;

/**
 Returns a character set containing all Apple Emoji.
 */
+ (NSMutableCharacterSet *)emojiMutableCharacterSet;

@end

NS_ASSUME_NONNULL_END
