//
//  UIImage+NFAllocInit_Orientation.h
//  iQNECT
//
//  Created by Ricardo Santos on 15/05/2014.
//  Copyright (c) 2014 NextFaze Pty Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (NFAllocInit_Orientation)

- (UIImage *)scaleAndRotateToMaxSize:(int)sizeInPixels;

@end

NS_ASSUME_NONNULL_END
