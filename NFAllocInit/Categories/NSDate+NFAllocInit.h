//
//  NSDate+NFAllocInit.h
//
//  Created by Shane Woolcock.
//  Copyright 2016 NextFaze. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (NFAllocInit)

+ (NSInteger)numberOfDaysInMonth:(NSInteger)month year:(NSInteger)year;
+ (NSInteger)currentYear;

+ (nullable NSDate *)dateWithComponentsDay:(NSInteger)day month:(NSInteger)month year:(NSInteger)year;
+ (nullable NSDate *)dateWithComponentsHour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second;
+ (nullable NSDate *)dateWithComponentsDay:(NSInteger)day month:(NSInteger)month year:(NSInteger)year hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second;

+ (NSDate *)today;
+ (NSDate *)tomorrow;
+ (NSDate *)yesterday;

- (NSDateComponents *)dateComponentsForDate;
- (NSDateComponents *)dateComponentsForTime;
- (nullable NSDate *)dateByAddingComponents:(NSDateComponents *)components;
- (nullable NSDate *)dateByIgnoringTime;

- (NSInteger)intervalToDate:(NSDate *)otherDate forUnit:(NSCalendarUnit)unit;

@end

NS_ASSUME_NONNULL_END
