//
//  UIColor+NFAllocInit.h
//  NFAllocInit
//
//  Created by Andrew Williams on 6/08/13.
//  Copyright (c) 2013 NextFaze SD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (NFAllocInit)

+ (UIColor *)colorForHex:(NSString *)hexColor;
+ (UIColor *)colorForHex:(NSString *)hexColor alpha:(CGFloat)alpha;

+ (UIColor *)colorWithHue:(CGFloat)hue saturation:(CGFloat)saturation luminance:(CGFloat)luminance;
+ (UIColor *)colorWithHue:(CGFloat)hue saturation:(CGFloat)saturation luminance:(CGFloat)luminance alpha:(CGFloat)alpha;

+ (UIColor *)colorWithCyan:(CGFloat)cyan magenta:(CGFloat)magenta yellow:(CGFloat)yellow key:(CGFloat)key;
+ (UIColor *)colorWithCyan:(CGFloat)cyan magenta:(CGFloat)magenta yellow:(CGFloat)yellow key:(CGFloat)key alpha:(CGFloat)alpha;

- (NSString*)hexValue;
- (NSString*)hexValueWithAlpha;

- (UIColor *)colorByDarkeningColor;
- (UIColor *)colorByWhiteningColorBy:(float)factor;
- (UIColor *)colorByFadingColor;
- (UIColor *)colorByChangingAlphaTo:(CGFloat)newAlpha;
- (UIColor *)colorByMuliplyingComponentsBy:(float)factor;

- (UIColor *)colorByLerpingToColor:(UIColor *)targetColor delta:(float)delta;

- (BOOL)getHue:(nullable CGFloat *)hue saturation:(nullable CGFloat *)saturation luminance:(nullable CGFloat *)luminance alpha:(nullable CGFloat *)alpha;
- (BOOL)getCyan:(nullable CGFloat *)cyan magenta:(nullable CGFloat *)magenta yellow:(nullable CGFloat *)yellow key:(nullable CGFloat *)key alpha:(nullable CGFloat *)alpha;

@end

NS_ASSUME_NONNULL_END
