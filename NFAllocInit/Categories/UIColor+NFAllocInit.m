//
//  UIColor+NFAllocInit.m
//  NFAllocInit
//
//  Created by Andrew Williams on 6/08/13.
//  Copyright (c) 2013 NextFaze SD. All rights reserved.
//

#import "UIColor+NFAllocInit.h"

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

@end
