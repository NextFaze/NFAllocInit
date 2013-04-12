//
//  NFViewUtils.h
//
//  Copyright 2012 NextFaze. All rights reserved.
//

// use this to set different background colours or other debug helpers for view layout
#define VIEW_DEBUG 0

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define kPadding 20.0
#define kHalfPadding kPadding/2.0

@interface NFViewUtils : NSObject {
    
}

+ (void)showAlertWithTitle:(NSString *)title andMessage:(NSString *)message;
+ (void)showAlertWithError:(NSError *)error;

+ (void)printAvailableFonts;

+ (UIColor *)randomColor;
+ (UIColor *)randomColorWithAlpha:(float)alpha;

+ (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size;

+ (void) setDefaultStyleForLabel:(UILabel*)pLabel;

+ (void)logRect:(CGRect)rect withDescription:(NSString*)description;
+ (void)logPoint:(CGPoint)point withDescription:(NSString*)description;
+ (void)logSize:(CGSize)size withDescription:(NSString*)description;

+ (void)removeShadowsFromWebView:(UIWebView *)webView;

+ (UIImage *)scaleAndRotateImage:(UIImage *)image toMaxSize:(int)maxSize;

@end

CGRect CalcRectWithBorder(CGRect rectInitial, int iBorderSize);
CGRect CalcBoundsFromFrame(CGRect rectFrame);
CGRect CalcRectBiggerThanRect(CGRect rectInitial, float dWidth, float dHeight);
