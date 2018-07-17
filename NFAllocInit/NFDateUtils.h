//
//  NFDateUtils.h
//  NFAllocInit
//
//  Created by Ricardo Santos on 20/03/13.
//  Copyright (c) 2013 NextFaze SD. All rights reserved.
//

#import <Foundation/Foundation.h>

#define NFDateFormatISO_8601     @"yyyy'-'MM'-'dd'T'HH':'mm':'ss'.'SSS'Z'"
#define NFDateFormatStandard    @"yyyy-MM-dd hh:mm:ss a"

NS_ASSUME_NONNULL_BEGIN

@interface NFDateUtils : NSObject

typedef NS_OPTIONS(NSUInteger, TimeUnitOptions) {
    TimeUnitSeconds = 1 << 0,
    TimeUnitMinutes = 1 << 1,
    TimeUnitHours = 1 << 2,
};

+ (NSString *)stringFromTimeInterval:(NSTimeInterval)timeInterval;
+ (NSString *)isoStyleStringFromTimeInterval:(NSTimeInterval)timeInterval displayingTimeUnitOptions:(TimeUnitOptions)timeUnitOptions;

+ (NSString *)stringFromDate:(NSDate *)date;
+ (NSString *)stringFromDate:(NSDate *)date withStyle:(NSDateFormatterStyle)style;
+ (NSString *)stringFromDate:(NSDate *)date withFormat:(NSString *)dateFormat;

+ (nullable NSDate *)dateFromString:(NSString *)string;
+ (nullable NSDate *)dateFromString:(NSString *)string withFormat:(NSString *)dateFormat;

@end

NS_ASSUME_NONNULL_END
