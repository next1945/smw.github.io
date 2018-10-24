//
//  UIViewController+NTK.h
//  NYSToolKit
//
//  Created by 倪刚 on 2018/10/22.
//  Copyright © 2018 NiYongsheng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (NTK)

/**
 If YES, then when this view controller is pushed into a controller hierarchy with a navigation bar, the navigation bar will slide out. Default is NO.
 */
@property(nonatomic, assign) BOOL hidesNavigationBarWhenPushed;

@end

NS_ASSUME_NONNULL_END
