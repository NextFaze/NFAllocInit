//
//  UIResponder+NFAllocInit.m
//  NFAllocInit
//
//  Created by swoolcock on 18/5/17.
//  Copyright © 2017 NextFaze SD. All rights reserved.
//

#import "UIResponder+NFAllocInit.h"

@implementation UIResponder (NFAllocInit)

+ (void)resignAnyFirstResponder
{
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder)
                                               to:nil
                                             from:nil
                                         forEvent:nil];
}

@end
