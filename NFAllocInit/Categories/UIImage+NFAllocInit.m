//
//  UIImage+NFAllocInit.m
//  NFAllocInit
//
//  Created by Andrew Williams on 26/07/13.
//  Copyright (c) 2013 NextFaze SD. All rights reserved.
//

#import "UIImage+NFAllocInit.h"

@implementation UIImage (NFAllocInit)

- (CGFloat)aspect {
    return self.size.width / self.size.height;
}

@end
