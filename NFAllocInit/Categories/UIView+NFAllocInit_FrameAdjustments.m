//
//  UIView+NFAllocInit_FrameAdjustments.m
//
//  Created by Andrew Williams on 2/12/11.
//  Copyright (c) 2011 NextFaze. All rights reserved.
//

#import "UIView+NFAllocInit_FrameAdjustments.h"

@implementation UIView (NFAllocInit_FrameAdjustments)

- (CGFloat)x {
    return self.frame.origin.x;
}

- (void)setX:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)y {
    return self.frame.origin.y;
}

- (void)setY:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)top {
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)top {
    [self setY:top];
}

- (CGFloat)bottom {
    return [self top] + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom {
    [self setTop:bottom - self.frame.size.height];
}

- (CGFloat)left {
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)left {
    [self setX:left];
}

- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right {
    [self setLeft:right - self.frame.size.width];
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)centerX {
    return self.frame.origin.x + self.frame.size.width / 2.0;
}

- (void)setCenterX:(CGFloat)centerX {
    [self setX:centerX - self.frame.size.width / 2.0];
}

- (CGFloat)centerY {
    return self.frame.origin.y + self.frame.size.height / 2.0;
}

- (void)setCenterY:(CGFloat)centerY {
    [self setY:centerY - self.frame.size.height / 2.0];
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGFloat)aspect {
    return self.width / self.height;
}

@end
