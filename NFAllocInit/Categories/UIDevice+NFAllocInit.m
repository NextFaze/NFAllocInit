//
//  UIDevice+NFAllocInit.m
//  NFAllocInit
//
//  Created by Andrew Williams on 9/07/13.
//  Copyright (c) 2013 NextFaze SD. All rights reserved.
//

#import "UIDevice+NFAllocInit.h"

@implementation UIDevice (NFAllocInit)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
- (NSString *)identifier {
    if([self respondsToSelector:@selector(identifierForVendor)]) {
        // identifierForVendor available in iOS 6.0 and later
        return [[self identifierForVendor] UUIDString];
    } else {
        // uniqueIdentifier usage will stop app from being accepted by iTunes connect
        return nil;
    }
}
#pragma clang diagnostic pop

@end
