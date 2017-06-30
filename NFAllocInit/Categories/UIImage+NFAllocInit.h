//
//  UIImage+NFAllocInit_NFAllocInit.h
//  NFAllocInit
//
//  Created by Andrew Williams on 26/07/13.
//  Copyright (c) 2013 NextFaze SD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (NFAllocInit)

@property (nonatomic, readonly) CGFloat aspect;

- (UIImage *)blurredImage;
- (UIImage *)blurredImageWithRadius:(CGFloat)radius;
- (UIImage *)grayscaleImage;

@end

NS_ASSUME_NONNULL_END
