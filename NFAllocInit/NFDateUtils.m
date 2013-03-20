//
//  NFDateUtils.m
//  NFAllocInit
//
//  Created by Ricardo Santos on 20/03/13.
//  Copyright (c) 2013 NextFaze SD. All rights reserved.
//

#import "NFDateUtils.h"

@implementation NFDateUtils


+ (NSString *)stringFromDate:(NSDate *)date
{
    return [NFDateUtils stringFromDate:date withStyle:NSDateFormatterShortStyle];
}

+ (NSString *)stringFromDate:(NSDate *)date withStyle:(NSDateFormatterStyle)style
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateStyle = style;
    NSString *string = [formatter stringFromDate:date];
    return string;
}

+ (NSString *)stringFromDate:(NSDate *)date withFormat:(NSString *)dateFormat
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = dateFormat;
    NSString *string = [formatter stringFromDate:date];
    return string;
}


+ (NSDate *)dateFromString:(NSString *)string
{
    return [NFDateUtils dateFromString:string withFormat:@"yyy-MM-dd hh:mm:ss a"];
}

+ (NSDate *)dateFromString:(NSString *)string withFormat:(NSString *)dateFormat
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = dateFormat;
    NSDate *date = [formatter dateFromString:string];
    return date;
}

@end
