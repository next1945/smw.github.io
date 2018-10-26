/*
 ╔════════════════════════╗
 ‖     Version:0.0.4      ‖
 ╚════════════════════════╝
 MIT License
 
 Copyright (c) 2018 倪刚
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 https://github.com/niyongsheng/NYSMC
 */
//  NYSTK.h
//  NYSTK
//
//  Created by 倪刚 on 2018/10/24.
//  Copyright © 2018 NiYongsheng. All rights reserved.
//

#import <UIKit/UIKit.h>

//! Project version number for NYSTK.
FOUNDATION_EXPORT double NYSTKVersionNumber;

//! Project version string for NYSTK.
FOUNDATION_EXPORT const unsigned char NYSTKVersionString[];

/** Category */
#import <NYSTK/NSString+NTK.h>
#import <NYSTK/NSData+NTK.h>
#import <NYSTK/NSCharacterSet+NTK.h>
#import <NYSTK/NSNumber+NTK.h>
#import <NYSTK/NSDate+NTK.h>
#import <NYSTK/UIButton+NTK.h>
#import <NYSTK/UIImage+NTK.h>
#import <NYSTK/UINavigationController+NTK.h>
#import <NYSTK/UIViewController+NTK.h>
#import <NYSTK/UIBarButtonItem+NTK.h>
#import <NYSTK/UIScrollView+NTK.h>
#import <NYSTK/UIDevice+NTK.h>
#import <NYSTK/UIView+NTKKeyBoardOffset.h>

/** Tools */
// 单例代码
#import <NYSTK/Single.h>
// 常用工具类
#import <NYSTK/HelperUtil.h>
// 文件管理\对象缓存
#import <NYSTK/NTKFileManager.h>
// 本地通知
#import <NYSTK/NTKLocalPushCenter.h>
// 自动选择根控制器
#import <NYSTK/NTKChooseRootController.h>
// 自定义中心凸起TabBar
#import <NYSTK/NYSBlugeTabBar.h>

