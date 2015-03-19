//
//  NFNetworkActivityIndicator.m
//  NFAllocInit
//
//  Created by Ricardo Santos on 19/03/2015.
//  Copyright (c) 2015 NextFaze SD. All rights reserved.
//
//  Adopted from FCUtilities/FCNetworkActivityIndicator by Marco Arment
//  https://github.com/marcoarment/FCUtilities/blob/master/FCUtilities/FCNetworkActivityIndicator.m
//

#import "NFNetworkActivityIndicator.h"

static int activityCount = 0;

@implementation NFNetworkActivityIndicator

+ (void)incrementActivityCount
{
    dispatch_async(dispatch_get_main_queue(), ^{
        activityCount++;
        [UIApplication.sharedApplication setNetworkActivityIndicatorVisible:YES];
    });
}

+ (void)decrementActivityCount
{
    dispatch_async(dispatch_get_main_queue(), ^{
        activityCount--;
        if (activityCount < 0) activityCount = 0;
        
        [UIApplication.sharedApplication setNetworkActivityIndicatorVisible:(activityCount > 0)];
    });
}

@end
