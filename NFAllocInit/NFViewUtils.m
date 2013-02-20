//
//  NFViewUtils.m
//
//  Copyright 2012-2013 NextFaze. All rights reserved.
//

#import "NFViewUtils.h"
#import <QuartzCore/QuartzCore.h>

#define ARC4RANDOM_MAX      0x100000000

#ifdef __IPHONE_6_0
# define ALIGN_CENTER NSTextAlignmentCenter
#else
# define ALIGN_CENTER UITextAlignmentCenter
#endif

@implementation NFViewUtils

#pragma mark - Alerts

+ (void)showAlertWithTitle:(NSString *)title andMessage:(NSString *)message
{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"OK", nil];
        [alert show];
    });
}

+ (void)showAlertWithError:(NSError *)error
{
    [NFViewUtils showAlertWithTitle:@"An error occured" andMessage:error.localizedDescription];
}

+ (void)printAvailableFonts
{
    NSArray *familyNames = [[NSArray alloc] initWithArray:[UIFont familyNames]];
    NSArray *fontNames;
    NSInteger indFamily, indFont;
    for (indFamily=0; indFamily<[familyNames count]; ++indFamily)
    {
        NFLog(@"Family name: %@", [familyNames objectAtIndex:indFamily]);
        fontNames = [[NSArray alloc] initWithArray:
                     [UIFont fontNamesForFamilyName:
                      [familyNames objectAtIndex:indFamily]]];
        for (indFont=0; indFont<[fontNames count]; ++indFont)
        {
            NFLog(@"    Font name: %@", [fontNames objectAtIndex:indFont]);
        }
    }
}

+ (UIColor *)randomColor
{
    return [self randomColorWithAlpha:1.0];
}

+ (UIColor *)randomColorWithAlpha:(float)alpha
{
    float randR = ((double)arc4random() / ARC4RANDOM_MAX);
    float randG = ((double)arc4random() / ARC4RANDOM_MAX);
    float randB = ((double)arc4random() / ARC4RANDOM_MAX);
    
    return [UIColor colorWithRed:randR green:randG blue:randB alpha:alpha];
}

+ (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size
{
    //Create a context of the appropriate size
    UIGraphicsBeginImageContext(size);
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    
    //Build a rect of appropriate size at origin 0,0
    CGRect fillRect = CGRectMake(0,0,size.width,size.height);
    
    //Set the fill color
    CGContextSetFillColorWithColor(currentContext, color.CGColor);
    
    //Fill the color
    CGContextFillRect(currentContext, fillRect);
    
    //Snap the picture and close the context
    UIImage *retval = UIGraphicsGetImageFromCurrentImageContext();
    //UIGraphicsGetImageFromCurrentImageContext(void);
    UIGraphicsEndImageContext();
    
    return retval;
}


+ (void) setDefaultStyleForLabel:(UILabel*)pLabel
{
    [pLabel setBackgroundColor:[UIColor clearColor]];
    [pLabel setTextColor:[UIColor whiteColor]];
    [pLabel setTextAlignment:ALIGN_CENTER];
    [pLabel setShadowColor:[UIColor blackColor]];
    [pLabel setShadowOffset:CGSizeMake(2.0, 2.0)];
    [pLabel setAdjustsFontSizeToFitWidth:YES];
} 

+ (void)logRect:(CGRect)rect withDescription:(NSString*)description
{
    NSLog(@"%@: x:%f y:%f width:%f height:%f", description, rect.origin.x, rect.origin.y, rect.size.width, rect.size.height);
}

+ (void)logPoint:(CGPoint)point withDescription:(NSString*)description
{
    NSLog(@"%@: x:%f y:%f", description, point.x, point.y);
}

+ (void)logSize:(CGSize)size withDescription:(NSString*)description
{
    NSLog(@"%@: width:%f height:%f", description, size.width, size.height);
}

+ (void)removeShadowsFromWebView:(UIWebView *)webView
{
    // Remove shadows
    if ([[webView subviews] count] > 0) {
        for (UIView* shadowView in [[[webView subviews] objectAtIndex:0] subviews]) {
            [shadowView setHidden:YES];
        }
        
        // unhide the last view so it is visible again because it has the content
        [[[[[webView subviews] objectAtIndex:0] subviews] lastObject] setHidden:NO];
    }
}

@end

CGRect CalcRectWithBorder(CGRect rectInitial, int iBorderSize)
{
	CGRect rectOutput = rectInitial;
	
	// Is there room to take off the border?
	if (rectOutput.size.width > iBorderSize * 2 &&
		rectOutput.size.height > iBorderSize * 2)
	{
		rectOutput.origin.x += iBorderSize;
		rectOutput.origin.y += iBorderSize;
		
		rectOutput.size.width -= (iBorderSize * 2);
		rectOutput.size.height -= (iBorderSize * 2);
	}
	
	return rectOutput;
}


CGRect CalcBoundsFromFrame(CGRect rectFrame)
{
	rectFrame.origin.x = 0;
	rectFrame.origin.y = 0;
	
	return rectFrame;
}

CGRect CalcRectBiggerThanRect(CGRect rectInitial, float dWidth, float dHeight)
{
    rectInitial.size.width += dWidth;
    rectInitial.size.height += dHeight;
    
    return rectInitial;
}
