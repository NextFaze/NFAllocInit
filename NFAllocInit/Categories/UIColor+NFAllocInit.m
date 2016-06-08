//
//  UIColor+NFAllocInit.m
//  NFAllocInit
//
//  Created by Andrew Williams on 6/08/13.
//  Copyright (c) 2013 NextFaze SD. All rights reserved.
//

#import "UIColor+NFAllocInit.h"

#define CLAMP(VAL,LOW,HIGH) MAX(LOW,MIN(HIGH,VAL))

@implementation UIColor (NFAllocInit)

+ (UIColor *) colorForHex:(NSString *)hexColor {
    CGFloat alpha = 1.0f;
    if(hexColor.length>7) {
        NSRange range = {hexColor.length-2,2};
        NSString *alphaHex = [hexColor substringWithRange:range];
        
        unsigned int a;
        [[NSScanner scannerWithString:alphaHex] scanHexInt:&a];
        
        alpha = ((float)a)/255.0;
        
        
        NSRange range2 = {0,hexColor.length-2};
        hexColor = [hexColor substringWithRange:range2];
    }
    
	return [UIColor colorForHex:hexColor alpha:alpha];
}


+ (UIColor *) colorForHex:(NSString *)hexColor alpha:(CGFloat)alpha {
	hexColor = [[hexColor stringByTrimmingCharactersInSet:
				 [NSCharacterSet whitespaceAndNewlineCharacterSet]
				 ] uppercaseString];
	
	// strip # if it appears
    if ([hexColor hasPrefix:@"#"])
		hexColor = [hexColor substringFromIndex:1];
	
    // if the value isn't 6 characters at this point return
    // the color black
    if ([hexColor length] != 6)
		return [UIColor grayColor];
	
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
	
    NSString *rString = [hexColor substringWithRange:range];
	
    range.location = 2;
    NSString *gString = [hexColor substringWithRange:range];
	
    range.location = 4;
    NSString *bString = [hexColor substringWithRange:range];
	
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
	
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:alpha];
}

+ (UIColor *) colorWithHue:(CGFloat)hue saturation:(CGFloat)saturation luminance:(CGFloat)luminance {
    return [UIColor colorWithHue:hue saturation:saturation luminance:luminance alpha:1.0];
}

+ (UIColor *) colorWithHue:(CGFloat)hue saturation:(CGFloat)saturation luminance:(CGFloat)luminance alpha:(CGFloat)alpha {
    CGFloat h = CLAMP(hue, 0, 1) * 6;
    CGFloat s = CLAMP(saturation, 0, 1);
    CGFloat l = CLAMP(luminance, 0, 1);
    CGFloat r = l, g = l, b = l, v = 0;
    
    if (l < 0.5) {
        v = l * (1 + s);
    } else {
        v = (l + s) - (s * l);
    }
    
    if (v > 0) {
        CGFloat m = l + l - v;
        CGFloat sv = (v - m) / v;
        CGFloat vsf = v * sv * (h - (int)h);
        CGFloat mid1 = m + vsf, mid2 = v - vsf;
        
        int sextant = (int)h % 6;
        switch (sextant) {
            case 0: { r = v; g = mid1; b = m; break; }
            case 1: { r = mid2; g = v; b = m; break; }
            case 2: { r = m; g = v; b = mid1; break; }
            case 3: { r = m; g = mid2; b = v; break; }
            case 4: { r = mid1; g = m; b = v; break; }
            case 5: { r = v; g = m; b = mid2; break; }
        }
    }
    
    return [UIColor colorWithRed:r green:g blue:b alpha:CLAMP(alpha, 0, 1)];
}

+ (UIColor *) colorWithCyan:(CGFloat)cyan magenta:(CGFloat)magenta yellow:(CGFloat)yellow key:(CGFloat)key {
    return [UIColor colorWithCyan:cyan magenta:magenta yellow:yellow key:key alpha:1.0];
}

+ (UIColor *) colorWithCyan:(CGFloat)cyan magenta:(CGFloat)magenta yellow:(CGFloat)yellow key:(CGFloat)key alpha:(CGFloat)alpha {
    CGFloat k = CLAMP(key, 0, 1);
    CGFloat r = 1 - MIN(1, CLAMP(cyan, 0, 1) * (1 - k) + k);
    CGFloat g = 1 - MIN(1, CLAMP(magenta, 0, 1) * (1 - k) + k);
    CGFloat b = 1 - MIN(1, CLAMP(yellow, 0, 1) * (1 - k) + k);
    return [UIColor colorWithRed:r green:g blue:b alpha:CLAMP(alpha, 0, 1)];
}

- (NSString*)hexValue {
    CGColorRef color = [self CGColor];
    NSString *titleColour = nil;
    
    size_t numComponents = CGColorGetNumberOfComponents(color);
    if (numComponents>=3 ) {
        const CGFloat *components = CGColorGetComponents(color);
        CGFloat red = components[0];
        CGFloat green = components[1];
        CGFloat blue = components[2];
        //CGFloat alpha = components[3];
        
        titleColour = [NSString stringWithFormat:@"#%2.2x%2.2x%2.2x",(int)round(red*255),(int)round(green*255),(int)round(blue*255)];
    }
    
    return titleColour;
}

- (NSString*)hexValueWithAlpha {
    CGColorRef color = [self CGColor];
    NSString *titleColour = nil;
    
    size_t numComponents = CGColorGetNumberOfComponents(color);
    if (numComponents >= 4) {
        const CGFloat *components = CGColorGetComponents(color);
        CGFloat red = components[0];
        CGFloat green = components[1];
        CGFloat blue = components[2];
        CGFloat alpha = components[3];
        
        titleColour = [NSString stringWithFormat:@"#%2.2x%2.2x%2.2x%2.2x",(int)round(red*255),(int)round(green*255),(int)round(blue*255),(int)round(alpha*255)];
    }
    
    return titleColour;
}

- (UIColor *)colorByFadingColor {
    return [self colorByMuliplyingComponentsBy:2];
}

#define WHITEN_COMPONENT(c, factor) (c + (1.0 - c) * factor)

- (UIColor *)colorByWhiteningColorBy:(float)factor {
    // oldComponents is the array INSIDE the original color
	// changing these changes the original, so we copy it
	CGFloat *oldComponents = (CGFloat *)CGColorGetComponents([self CGColor]);
	CGFloat newComponents[4];
    
	size_t numComponents = CGColorGetNumberOfComponents([self CGColor]);
    
	switch (numComponents)
	{
		case 2:
		{
			//grayscale
			newComponents[0] = WHITEN_COMPONENT(oldComponents[0], factor);
			newComponents[1] = WHITEN_COMPONENT(oldComponents[0], factor);
			newComponents[2] = WHITEN_COMPONENT(oldComponents[0], factor);
			newComponents[3] = oldComponents[1];
			break;
		}
		case 4:
		{
			//RGBA
			newComponents[0] = WHITEN_COMPONENT(oldComponents[0], factor);
			newComponents[1] = WHITEN_COMPONENT(oldComponents[1], factor);
			newComponents[2] = WHITEN_COMPONENT(oldComponents[2], factor);
			newComponents[3] = oldComponents[3];
			break;
		}
	}
    
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	CGColorRef newColor = CGColorCreate(colorSpace, newComponents);
	CGColorSpaceRelease(colorSpace);
    
	UIColor *retColor = [UIColor colorWithCGColor:newColor];
	CGColorRelease(newColor);
    
	return retColor;
}

- (UIColor *)colorByDarkeningColor {
    return [self colorByMuliplyingComponentsBy:0.7];
}

- (UIColor *)colorByMuliplyingComponentsBy:(float)factor
{
	// oldComponents is the array INSIDE the original color
	// changing these changes the original, so we copy it
	CGFloat *oldComponents = (CGFloat *)CGColorGetComponents([self CGColor]);
	CGFloat newComponents[4];
    
	size_t numComponents = CGColorGetNumberOfComponents([self CGColor]);
    
	switch (numComponents)
	{
		case 2:
		{
			//grayscale
			newComponents[0] = oldComponents[0] * factor;
			newComponents[1] = oldComponents[0] * factor;
			newComponents[2] = oldComponents[0] * factor;
			newComponents[3] = oldComponents[1];
			break;
		}
		case 4:
		{
			//RGBA
			newComponents[0] = oldComponents[0] * factor;
			newComponents[1] = oldComponents[1] * factor;
			newComponents[2] = oldComponents[2] * factor;
			newComponents[3] = oldComponents[3];
			break;
		}
	}
    
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	CGColorRef newColor = CGColorCreate(colorSpace, newComponents);
	CGColorSpaceRelease(colorSpace);
    
	UIColor *retColor = [UIColor colorWithCGColor:newColor];
	CGColorRelease(newColor);
    
	return retColor;
}

- (UIColor *)colorByChangingAlphaTo:(CGFloat)newAlpha;
{
	// oldComponents is the array INSIDE the original color
	// changing these changes the original, so we copy it
	CGFloat *oldComponents = (CGFloat *)CGColorGetComponents([self CGColor]);
	size_t numComponents = CGColorGetNumberOfComponents([self CGColor]);
	CGFloat newComponents[4];
    
	switch (numComponents)
	{
		case 2:
		{
			//grayscale
			newComponents[0] = oldComponents[0];
			newComponents[1] = oldComponents[0];
			newComponents[2] = oldComponents[0];
			newComponents[3] = newAlpha;
			break;
		}
		case 4:
		{
			//RGBA
			newComponents[0] = oldComponents[0];
			newComponents[1] = oldComponents[1];
			newComponents[2] = oldComponents[2];
			newComponents[3] = newAlpha;
			break;
		}
	}
    
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	CGColorRef newColor = CGColorCreate(colorSpace, newComponents);
	CGColorSpaceRelease(colorSpace);
    
	UIColor *retColor = [UIColor colorWithCGColor:newColor];
	CGColorRelease(newColor);
    
	return retColor;
}

- (UIColor *)colorByLerpingToColor:(UIColor *)targetColor delta:(float)delta
{
    CGFloat srcHue, srcSaturation, srcBrightness, srcAlpha, destHue, destSaturation, destBrightness, destAlpha;
    if (![self getHue:&srcHue saturation:&srcSaturation brightness:&srcBrightness alpha:&srcAlpha])
        return self;
    if (![targetColor getHue:&destHue saturation:&destSaturation brightness:&destBrightness alpha:&destAlpha])
        return self;
    return [UIColor colorWithHue:srcHue + (destHue - srcHue) * delta
                      saturation:srcSaturation + (destSaturation - srcSaturation) * delta
                      brightness:srcBrightness + (destBrightness - srcBrightness) * delta
                           alpha:srcAlpha + (destAlpha - srcAlpha) * delta];
}

- (BOOL)getHue:(nullable CGFloat *)hue saturation:(nullable CGFloat *)saturation luminance:(nullable CGFloat *)luminance alpha:(nullable CGFloat *)alpha
{
    CGFloat r = 0, g = 0, b = 0, a = 0;
    CGFloat h = 0, s = 0, l = 0;
    if (![self getRed:&r green:&g blue:&b alpha:&a]) {
        return NO;
    }
    
    CGFloat v = MAX(MAX(r, g), b);
    CGFloat m = MIN(MIN(r, g), b);
    l = (m + v) / 2.0;
    
    if (l > 0) {
        CGFloat vm = v - m;
        s = vm;
        
        if (s > 0) {
            if (l <= 0.5) {
                s /= v + m;
            } else {
                s /= 2 - v - m;
            }
            
            CGFloat r2 = (v - r) / vm;
            CGFloat g2 = (v - g) / vm;
            CGFloat b2 = (v - b) / vm;
            if (r == v && g == m) {
                h = 5 + b2;
            } else if (r == v && g != m) {
                h = 1 - g2;
            } else if (g == v && b == m) {
                h = 1 + r2;
            } else if (g == v && b != m) {
                h = 3 - b2;
            } else if (r == m) {
                h = 3 + g2;
            } else {
                h = 5 - r2;
            }
        }
    }
    
    h /= 6;
    if (h == 1) {
        h = 0;
    }
    
    if (hue)
        *hue = h;
    if (saturation)
        *saturation = s;
    if (luminance)
        *luminance = l;
    if (alpha)
        *alpha = a;
    
    return YES;
}

- (BOOL)getCyan:(nullable CGFloat *)cyan magenta:(nullable CGFloat *)magenta yellow:(nullable CGFloat *)yellow key:(nullable CGFloat *)key alpha:(nullable CGFloat *)alpha
{
    CGFloat r = 0, g = 0, b = 0, a = 0;
    CGFloat c = 0, m = 0, y = 0, k = 0;
    if (![self getRed:&r green:&g blue:&b alpha:&a]) {
        return NO;
    }
    
    if (r == 0 && g == 0 && b == 0) {
        k = 1;
        
    } else {
        c = 1 - r;
        m = 1 - g;
        y = 1 - b;
        k = MIN(MIN(c, m), y);
        c = (c - k) / (1 - k);
        m = (m - k) / (1 - k);
        y = (y - k) / (1 - k);
    }
    
    if (cyan)
        *cyan = c;
    if (magenta)
        *magenta = m;
    if (yellow)
        *yellow = y;
    if (key)
        *key = k;
    if (alpha)
        *alpha = a;
    
    return YES;
}

@end
