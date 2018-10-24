//
//  UIDevice+NTK.h
//  NYSToolKit
//
//  Created by 倪刚 on 2018/10/22.
//  Copyright © 2018 NiYongsheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <mach/host_info.h>

typedef void (^ cameraAuthorziedBlock) (void);

NS_ASSUME_NONNULL_BEGIN

@interface UIDevice (NTK)

#pragma mark - Device Information
///=============================================================================
/// @name Device Information
///=============================================================================

/// Whether the device is iPad/iPad mini.
@property (nonatomic, readonly, getter=isPad) BOOL isPad;

/// Whether the device is a simulator.
@property (nonatomic, readonly, getter=isSimulator) BOOL isSimulator;

/// Wherher the device can make phone calls.
@property (nonatomic, readonly, getter=canMakePhoneCalls) BOOL canMakePhoneCalls;

/// The device's machine model.  e.g. "iPhone6,1" "iPad4,6"
/// @see http://theiphonewiki.com/wiki/Models
@property (nonatomic, readonly, getter=machineModel) NSString *machineModel;

/// The device's machine model name. e.g. "iPhone 5s" "iPad mini 2"
/// @see http://theiphonewiki.com/wiki/Models
@property (nonatomic, readonly, getter=machineModelName) NSString *machineModelName;

/// 屏幕大小，高大于宽
+ (CGSize) screenSize;

/// 系统版本，以float形式返回
- (CGFloat)systemVersionByFloat;

/// 系统版本，以float形式返回
+ (CGFloat)systemVersionByFloat;

#pragma mark - Disk Space
///=============================================================================
/// @name Disk Space
///=============================================================================

/// Total disk space in byte. (-1 when error occurs)
@property (nonatomic, readonly, getter=diskSpace) int64_t diskSpace;

/// Free disk space in byte. (-1 when error occurs)
@property (nonatomic, readonly, getter=diskSpaceFree) int64_t diskSpaceFree;

/// Used disk space in byte. (-1 when error occurs)
@property (nonatomic, readonly, getter=diskSpaceUsed) int64_t diskSpaceUsed;


#pragma mark - Memory Information
///=============================================================================
/// @name Memory Information
///=============================================================================

/// Total physical memory in byte. (-1 when error occurs)
@property (nonatomic, readonly, getter=memoryTotal) int64_t memoryTotal;

/// Used (active + inactive + wired) memory in byte. (-1 when error occurs)
@property (nonatomic, readonly, getter=memoryUsed) int64_t memoryUsed;

/// Free memory in byte. (-1 when error occurs)
@property (nonatomic, readonly, getter=memoryFree) int64_t memoryFree;

/// Acvite memory in byte. (-1 when error occurs)
@property (nonatomic, readonly, getter=memoryActive) int64_t memoryActive;

/// Inactive memory in byte. (-1 when error occurs)
@property (nonatomic, readonly, getter=memoryInactive) int64_t memoryInactive;

/// Wired memory in byte. (-1 when error occurs)
@property (nonatomic, readonly, getter=memoryWired) int64_t memoryWired;

/// Purgable memory in byte. (-1 when error occurs)
@property (nonatomic, readonly, getter=memoryPurgable) int64_t memoryPurgable;

@property (nonatomic,copy ,readonly, getter=CPUType) NSString *CPUType;
@property (nonatomic,copy ,readonly, getter=CPUSubtype) NSString *CPUSubtype;


#pragma mark - System version compare
///=============================================================================
/// @name System version compare
///=============================================================================

- (BOOL)systemVersionLowerThan:(NSString*)version;
- (BOOL)systemVersionNotHigherThan:(NSString *)version;
- (BOOL)systemVersionHigherThan:(NSString*)version;
- (BOOL)systemVersionNotLowerThan:(NSString *)version;

#pragma mark - Others
///=============================================================================
/// @name Others
///=============================================================================

/// 设备是否越狱
/// Whether the device is jailbroken.
@property (nonatomic, readonly, getter=isJailbroken) BOOL isJailbroken;

//
+ (void)cameraAuthorzied:(cameraAuthorziedBlock)authorizedBlock notAuthorized:(cameraAuthorziedBlock)notAuthorizedlock;

-(NSString*)deviceID;

@end

NS_ASSUME_NONNULL_END
