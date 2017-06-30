// UIImage+NFAllocInit_Alpha.h
// Created by Trevor Harmon on 9/20/09.
// Free for personal or commercial use, with or without modification.
// No warranty is expressed or implied.

// Helper methods for adding an alpha layer to an image

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (NFAllocInit_Alpha)

- (BOOL)hasAlpha;
- (UIImage *)imageWithAlpha;
- (UIImage *)transparentBorderImage:(NSUInteger)borderSize;
- (CGImageRef)newBorderMask:(NSUInteger)borderSize size:(CGSize)size;

@end

NS_ASSUME_NONNULL_END
