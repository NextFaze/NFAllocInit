//
//  UIImage+NFAllocInit_NFAllocInit.h
//  NFAllocInit
//
//  Created by Andrew Williams on 26/07/13.
//  Copyright (c) 2013 NextFaze SD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (NFAllocInit)

@property (nonatomic, readonly) CGFloat aspect;

- (UIImage *)blurredImage;

@end
