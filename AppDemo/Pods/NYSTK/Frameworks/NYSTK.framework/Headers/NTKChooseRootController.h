//
//  NTKChooseRootController.h
//  NYSToolKit
//
//  Created by 倪刚 on 2018/10/22.
//  Copyright © 2018 NiYongsheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^LoginBlock)(void);
typedef void (^TabBarBlock)(void);
typedef void (^NewfeatureBlock)(void);

NS_ASSUME_NONNULL_BEGIN

@interface NTKChooseRootController : NSObject

/** 选择根控制器 */
+ (void)ChooseRootController:(LoginBlock)LoginBlock OrtabBarVC:(TabBarBlock)TabBarBlock OrNewfeatureVC:(NewfeatureBlock)NewfeatureBlock withAccountKey:(NSString *)Accountkey andTokenKey:(NSString *)TokenKey;

@end

NS_ASSUME_NONNULL_END
