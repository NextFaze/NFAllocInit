//
//  NFDateUtils.h
//  NFAllocInit
//
//  Created by Ricardo Santos on 20/03/13.
//  Copyright (c) 2013 NextFaze SD. All rights reserved.
//

#import <Foundation/Foundation.h>

#define NFDateFormatISO_8601     @"yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"
#define NFDateFormatStandard    @"yyyy-MM-dd hh:mm:ss a"

@interface NFDateUtils : NSObject

+ (NSString *)stringFromTimeInterval:(NSTimeInterval)timeInterval;

+ (NSString *)stringFromDate:(NSDate *)date;
+ (NSString *)stringFromDate:(NSDate *)date withStyle:(NSDateFormatterStyle)style;
+ (NSString *)stringFromDate:(NSDate *)date withFormat:(NSString *)dateFormat;

+ (NSDate *)dateFromString:(NSString *)string;
+ (NSDate *)dateFromString:(NSString *)string withFormat:(NSString *)dateFormat;


@end
