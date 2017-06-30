//
//  UIBarButtonItem+NFAllocInit.m
//  NFAllocInit
//
//  Created by swoolcock on 18/5/17.
//  Copyright © 2017 NextFaze SD. All rights reserved.
//

#import "UIBarButtonItem+NFAllocInit.h"

@implementation UIBarButtonItem (NFAllocInit)

- (instancetype)initWithFixedSpaceWidth:(CGFloat)fixedSpaceWidth
{
    self = [self initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                      target:nil
                                      action:nil];
    if (self) {
        self.width = fixedSpaceWidth;
    }
    return self;
}

@end
