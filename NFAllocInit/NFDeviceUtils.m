//
//  NFDeviceUtils.m
//  NFAllocInit
//
//  Created by Ricardo Santos on 18/04/13.
//  Copyright (c) 2013 NextFaze SD. All rights reserved.
//

#import "NFDeviceUtils.h"

@implementation NFDeviceUtils

+ (BOOL)isPad
{
    return [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad;
}

+ (BOOL)is4inch
{
    if ([self isPad]) return NO;
    
    CGRect bounds = [[UIScreen mainScreen] applicationFrame];
    bool isScreen4Inch = bounds.size.height > 480;
    return isScreen4Inch;
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
    //http://stackoverflow.com/questions/413242/how-do-i-detect-that-an-sdk-app-is-running-on-a-jailbroken-phone
    NSString *filePath = @"/Applications/Cydia.app";
    return [[NSFileManager defaultManager] fileExistsAtPath:filePath];
}

+ (BOOL) isPirated {
    //http://thwart-ipa-cracks.blogspot.com/2008/11/detection.html
    NSDictionary *info = [[NSBundle mainBundle] infoDictionary];
    return ([info objectForKey: @"SignerIdentity"] != nil);
}

@end
