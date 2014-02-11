//
//  NFDateUtils.m
//  NFAllocInit
//
//  Created by Ricardo Santos on 20/03/13.
//  Copyright (c) 2013 NextFaze SD. All rights reserved.
//

#import "NFDateUtils.h"

@implementation NFDateUtils

+ (NSString *)stringForValue:(NSUInteger)value withNonPluralUnit:(NSString *)unit
{
    if (value == 1) {
        return [NSString stringWithFormat:@"%lu %@", (unsigned long)value, unit];
    }
    return [NSString stringWithFormat:@"%lu %@s", (unsigned long)value, unit];
}

+ (NSString *)stringFromTimeInterval:(NSTimeInterval)timeInterval
{
    NSUInteger time = (NSUInteger)timeInterval;
    NSUInteger seconds = time % 60;
    NSUInteger minutes = time / 60;
    NSUInteger hours = minutes / 60;
    NSUInteger days = hours / 24;
    NSUInteger weeks = days / 7;
    
    NSString *string = nil;
    if (weeks > 0) {
        string = [self stringForValue:weeks withNonPluralUnit:@"week"];
    } else if (days > 0) {
        string = [self stringForValue:days withNonPluralUnit:@"day"];
    } else if (hours > 0) {
        string = [self stringForValue:hours withNonPluralUnit:@"hour"];
    } else if (minutes > 0) {
        string = [self stringForValue:minutes withNonPluralUnit:@"minute"];
    } else {
        string = [self stringForValue:seconds withNonPluralUnit:@"second"];
    }
    
    return string;
}


+ (NSString *)stringFromDate:(NSDate *)date
{
    return [NFDateUtils stringFromDate:date withFormat:NFDateFormatISO_8601];
}

+ (NSString *)stringFromDate:(NSDate *)date withStyle:(NSDateFormatterStyle)style
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateStyle = style;
    
    NSTimeZone *timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    [formatter setTimeZone:timeZone];
    
    NSString *string = [formatter stringFromDate:date];
    return string;
}

+ (NSString *)stringFromDate:(NSDate *)date withFormat:(NSString *)dateFormat
{
    if(date == nil) return @"";
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = dateFormat;
    
    NSTimeZone *timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    [formatter setTimeZone:timeZone];
    
    NSString *string = [formatter stringFromDate:date];
    return string;
}


+ (NSDate *)dateFromString:(NSString *)string
{
    return [NFDateUtils dateFromString:string withFormat:NFDateFormatISO_8601];
}

+ (NSDate *)dateFromString:(NSString *)string withFormat:(NSString *)dateFormat
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = dateFormat;
    NSDate *date = [formatter dateFromString:string];
    return date;
}

@end
