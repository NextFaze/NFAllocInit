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
    [NFViewUtils showAlertWithTitle:@"An error occurred" andMessage:error.localizedDescription];
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

+ (UIImage *)imageWithColor:(UIColor *)color
{
    return [NFViewUtils imageWithColor:color andSize:CGSizeMake(1.0, 1.0)];
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

+ (UIImage *)scaleAndRotateImage:(UIImage *)image toMaxSize:(int)maxSize
{
    int kMaxResolution = maxSize;
    
    CGImageRef imgRef = image.CGImage;
    
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
    
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    CGRect bounds = CGRectMake(0, 0, width, height);
    if (width > kMaxResolution || height > kMaxResolution) {
        CGFloat ratio = width/height;
        if (ratio > 1) {
            bounds.size.width = kMaxResolution;
            bounds.size.height = bounds.size.width / ratio;
        }
        else {
            bounds.size.height = kMaxResolution;
            bounds.size.width = bounds.size.height * ratio;
        }
    }
    
    CGFloat scaleRatio = bounds.size.width / width;
    CGSize imageSize = CGSizeMake(CGImageGetWidth(imgRef), CGImageGetHeight(imgRef));
    CGFloat boundHeight;
    UIImageOrientation orient = image.imageOrientation;
    switch(orient) {
            
        case UIImageOrientationUp: //EXIF = 1
            transform = CGAffineTransformIdentity;
            break;
            
        case UIImageOrientationUpMirrored: //EXIF = 2
            transform = CGAffineTransformMakeTranslation(imageSize.width, 0.0);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            break;
            
        case UIImageOrientationDown: //EXIF = 3
            transform = CGAffineTransformMakeTranslation(imageSize.width, imageSize.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationDownMirrored: //EXIF = 4
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.height);
            transform = CGAffineTransformScale(transform, 1.0, -1.0);
            break;
            
        case UIImageOrientationLeftMirrored: //EXIF = 5
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, imageSize.width);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationLeft: //EXIF = 6
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.width);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationRightMirrored: //EXIF = 7
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeScale(-1.0, 1.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        case UIImageOrientationRight: //EXIF = 8
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, 0.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        default:
            [NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"];
            
    }
    
    UIGraphicsBeginImageContext(bounds.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (orient == UIImageOrientationRight || orient == UIImageOrientationLeft) {
        CGContextScaleCTM(context, -scaleRatio, scaleRatio);
        CGContextTranslateCTM(context, -height, 0);
    }
    else {
        CGContextScaleCTM(context, scaleRatio, -scaleRatio);
        CGContextTranslateCTM(context, 0, -height);
    }
    
    CGContextConcatCTM(context, transform);
    
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return imageCopy;
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
