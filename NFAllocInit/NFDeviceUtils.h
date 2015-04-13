//
//  NFDeviceUtils.h
//  NFAllocInit
//
//  Created by Ricardo Santos on 18/04/13.
//  Copyright (c) 2013 NextFaze SD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NFDeviceUtils : NSObject

+ (BOOL)isOSAtLeastVersion:(float)osVersion;
+ (float)systemVersion;
+ (BOOL)isPad;
+ (BOOL)is3_5inch;
+ (BOOL)is4inch;
+ (BOOL)is4_7inch;
+ (BOOL)is5_5inch;
+ (BOOL)isSimulator;
+ (BOOL)isTwitterAvailable;
+ (BOOL)isSocialAvailable;
+ (BOOL)isJailbroken;
+ (BOOL)isPirated;

@end
