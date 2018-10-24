//
//  NSDate+NTK.h
//  NYSToolKit
//
//  Created by 倪刚 on 2018/10/22.
//  Copyright © 2018 NiYongsheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (NTK)

#pragma mark - 时间部分
///=============================================================================
/// @name 时间部分
///=============================================================================
@property (nonatomic, readonly) NSInteger year; ///< Year component
@property (nonatomic, readonly) NSInteger month; ///< Month component
@property (nonatomic, readonly) NSInteger day; ///< Day component
@property (nonatomic, readonly) NSInteger hour; ///< Hour component
@property (nonatomic, readonly) NSInteger minute; ///< Minute component
@property (nonatomic, readonly) NSInteger second; ///< Second component
@property (nonatomic, readonly) NSInteger nanosecond; ///< Nanosecond component
@property (nonatomic, readonly) NSInteger weekday; ///< Weekday component
@property (nonatomic, readonly) NSInteger weekdayOrdinal; ///< WeekdayOrdinal component
@property (nonatomic, readonly) NSInteger weekOfMonth; ///< WeekOfMonth component
@property (nonatomic, readonly) NSInteger weekOfYear; ///< WeekOfYear component
@property (nonatomic, readonly) NSInteger yearForWeekOfYear; ///< YearForWeekOfYear component
@property (nonatomic, readonly) NSInteger quarter; ///< Quarter component
@property (nonatomic, readonly) BOOL isLeapMonth; ///< 是否闰月
@property (nonatomic, readonly) BOOL isLeapYear; ///< 是否闰年

#pragma mark - 日期修改
///=============================================================================
/// @name 日期修改
///=============================================================================
- (NSDate *)dateByAddingYears:(NSInteger)years; /// 从这个日期加上N年
- (NSDate *)dateByAddingMonths:(NSInteger)months; /// 从这个日期加上N月
- (NSDate *)dateByAddingWeeks:(NSInteger)weeks; /// 从这个日期加上N日
- (NSDate *)dateByAddingDays:(NSInteger)days; /// 从这个日期加上N天
- (NSDate *)dateByAddingHours:(NSInteger)hours; /// 从这个日期加上N小时
- (NSDate *)dateByAddingMinutes:(NSInteger)minutes; /// 从这个日期加上N分钟
- (NSDate *)dateByAddingSeconds:(NSInteger)seconds; /// 从这个日期加上N秒


- (NSString *)stringForTimeLaifeng;
- (NSString *)stringForDateline;
- (NSString *)stringForTimeToday;
- (NSString *)stringForTimeTomorrow;
- (NSString *)stringForTimeCommon;
- (NSString *)stringForHourLaifeng;
- (NSString *)stringForDayLaifeng;
- (NSAttributedString *)attributedStringForTimeToday;
- (NSAttributedString *)attributedStringForTimeTomorrow;
- (NSAttributedString *)attributedStringForCommon;

- (NSString *)stringForFeed;
- (BOOL)isToday;
- (BOOL)isYesterday;
- (BOOL)isTodayBirthday;
- (BOOL)isLast30Mins;


@end

NS_ASSUME_NONNULL_END
