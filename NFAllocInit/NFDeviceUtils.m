//
//  NFDeviceUtils.m
//  NFAllocInit
//
//  Created by Ricardo Santos on 18/04/13.
//  Copyright (c) 2013 NextFaze SD. All rights reserved.
//

#import "NFDeviceUtils.h"

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

@implementation NFDeviceUtils

+ (BOOL)isOSAtLeastVersion:(float)osVersion
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= osVersion) {
        return YES;
    }
    return NO;
}

+ (float)systemVersion {
    return [[[UIDevice currentDevice] systemVersion] floatValue];
}

+ (BOOL)isPad
{
    return [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad;
}

+ (BOOL)is3_5inch
{
    if ([self isPad]) return NO;
    return SCREEN_MAX_LENGTH == 480.0;
}

+ (BOOL)is4inch
{
    if ([self isPad]) return NO;
    return SCREEN_MAX_LENGTH == 568.0;
}

+ (BOOL)is4_7inch
{
    if ([self isPad]) return NO;
    return SCREEN_MAX_LENGTH == 667.0;
}

+ (BOOL)is5_5inch
{
    if ([self isPad]) return NO;
    return SCREEN_MAX_LENGTH == 736.0;
}

+ (BOOL)isSimulator
{
    BOOL isSimulator = NO;
#if TARGET_IPHONE_SIMULATOR
    isSimulator = YES;
#endif
    return isSimulator;
}

+ (BOOL)isTwitterAvailable {
    return NSClassFromString(@"TWTweetComposeViewController") != nil;
}

+ (BOOL)isSocialAvailable {
    return NSClassFromString(@"SLComposeViewController") != nil;
}

+ (BOOL)isJailbroken {
    //http://stackoverflow.com/questions/9565609/how-to-detect-if-your-iphone-is-jailbroken/9568130#9568130
#if TARGET_IPHONE_SIMULATOR
    return NO;
#else
    FILE *f = fopen("/bin/bash", "r");
    
    if (errno == ENOENT)
    {
        // device is NOT jailbroken
        fclose(f);
        return NO;
    }
    else {
        // device IS jailbroken
        fclose(f);
        return YES;
    }
#endif
}

+ (BOOL)isPirated {
    //http://thwart-ipa-cracks.blogspot.com/2008/11/detection.html
    NSDictionary *info = [[NSBundle mainBundle] infoDictionary];
    return ([info objectForKey: @"SignerIdentity"] != nil);
}

@end
