//
//  UIView+NFAllocInit_FrameAdjustments.h
//
//  Created by Andrew Williams on 2/12/11.
//  Copyright (c) 2011 NextFaze. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (NFAllocInit_FrameAdjustments)

@property (nonatomic, assign) CGFloat x, y, top, bottom, left, right, width, height, centerX, centerY;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, readonly) CGFloat aspect;

@end
