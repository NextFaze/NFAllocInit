//
//  NSDate+NFAllocInit.m
//
//  Created by Shane Woolcock.
//  Copyright 2016 NextFaze. All rights reserved.
//

#import "NSDate+NFAllocInit.h"

@implementation NSDate (NFAllocInit)

+ (NSInteger)numberOfDaysInMonth:(NSInteger)month year:(NSInteger)year
{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.month = month;
    components.year = year;
    NSDate *date = [[NSCalendar currentCalendar] dateFromComponents:components];
    NSRange range = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return (NSInteger)range.length;
}

+ (NSInteger)currentYear
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:[NSDate date]];
    return components.year;
}

+ (NSDate *)dateWithComponentsDay:(NSInteger)day month:(NSInteger)month year:(NSInteger)year
{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.day = day;
    components.month = month;
    components.year = year;
    return [[NSCalendar currentCalendar] dateFromComponents:components];
}

+ (NSDate *)dateWithComponentsHour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second
{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.hour = hour;
    components.minute = minute;
    components.second = second;
    return [[NSCalendar currentCalendar] dateFromComponents:components];
}

+ (NSDate *)dateWithComponentsDay:(NSInteger)day month:(NSInteger)month year:(NSInteger)year hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second
{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.day = day;
    components.month = month;
    components.year = year;
    components.hour = hour;
    components.minute = minute;
    components.second = second;
    return [[NSCalendar currentCalendar] dateFromComponents:components];
}

+ (NSDate *)today
{
    return [[NSDate date] dateByIgnoringTime];
}

+ (NSDate *)tomorrow
{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.day = 1;
    return [[NSDate today] dateByAddingComponents:components];
}

+ (NSDate *)yesterday
{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.day = -1;
    return [[NSDate today] dateByAddingComponents:components];
}

- (NSDateComponents *)dateComponentsForDate
{
    return [[NSCalendar currentCalendar] components:(NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear) fromDate:self];
}

- (NSDateComponents *)dateComponentsForTime
{
    return [[NSCalendar currentCalendar] components:(NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond) fromDate:self];
}

- (NSDate *)dateByAddingComponents:(NSDateComponents *)components
{
    return [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self options:NSCalendarWrapComponents];
}

- (NSDate *)dateByIgnoringTime
{
    return [[NSCalendar currentCalendar] dateFromComponents:[self dateComponentsForDate]];
}

- (NSInteger)intervalToDate:(NSDate *)otherDate forUnit:(NSCalendarUnit)unit
{
    NSTimeInterval difference = [otherDate timeIntervalSinceDate:self];
    if (unit == NSCalendarUnitMinute) {
        return floor(difference / 60);
    } else if (unit == NSCalendarUnitHour) {
        return floor(difference / (60 * 60));
    } else if (unit == NSCalendarUnitDay) {
        return floor(difference / (60 * 60 * 24));
    } else {
        return floor(difference);
    }
}

@end
