//
//  NFDateUtils.h
//  NFAllocInit
//
//  Created by Ricardo Santos on 20/03/13.
//  Copyright (c) 2013 NextFaze SD. All rights reserved.
//

#import <Foundation/Foundation.h>

#define NFDateFormatStandard @"yyyy-MM-dd hh:mm:ss a"

@interface NFDateUtils : NSObject

+ (NSString *)stringFromDate:(NSDate *)date;
+ (NSString *)stringFromDate:(NSDate *)date withStyle:(NSDateFormatterStyle)style;
+ (NSString *)stringFromDate:(NSDate *)date withFormat:(NSString *)dateFormat;

+ (NSDate *)dateFromString:(NSString *)string;
+ (NSDate *)dateFromString:(NSString *)string withFormat:(NSString *)dateFormat;


@end
