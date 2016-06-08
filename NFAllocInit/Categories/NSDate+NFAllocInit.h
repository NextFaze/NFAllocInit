//
//  NSDate+NFAllocInit.h
//
//  Created by Shane Woolcock.
//  Copyright 2016 NextFaze. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (NFAllocInit)

+ (NSInteger)numberOfDaysInMonth:(NSInteger)month year:(NSInteger)year;
+ (NSInteger)currentYear;

+ (NSDate *)dateWithComponentsDay:(NSInteger)day month:(NSInteger)month year:(NSInteger)year;
+ (NSDate *)dateWithComponentsHour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second;
+ (NSDate *)dateWithComponentsDay:(NSInteger)day month:(NSInteger)month year:(NSInteger)year hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second;

+ (NSDate *)today;
+ (NSDate *)tomorrow;
+ (NSDate *)yesterday;

- (NSDateComponents *)dateComponentsForDate;
- (NSDateComponents *)dateComponentsForTime;
- (NSDate *)dateByAddingComponents:(NSDateComponents *)components;
- (NSDate *)dateByIgnoringTime;

- (NSInteger)intervalToDate:(NSDate *)otherDate forUnit:(NSCalendarUnit)unit;

@end
