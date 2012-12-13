//
//  NFViewUtils.h
//
//  Copyright 2012 NextFaze. All rights reserved.
//

// use this to set different background colours or other debug helpers for view layout
#define VIEW_DEBUG 0

#define kPadding 20

@interface NFViewUtils : NSObject {
    
}

+ (void)printAvailableFonts;

+ (UIFont *)fontRegularWithSize:(float)size;
+ (UIFont *)fontBoldWithSize:(float)size;
+ (UIFont *)randomFontWithSize:(float)size;

+ (UIColor *)randomColor;
+ (UIColor *)randomColorWithAlpha:(float)alpha;
+ (UIColor *)navBarColor;
+ (UIColor *)tabColor;
+ (UIColor *)lightGrayTextColor;
+ (UIColor *)grayTextColor;
+ (UIColor *)darkGrayTextColor;
+ (UIColor *)grayBackgroundColor;

+ (void) setDefaultStyleForLabel:(UILabel*)pLabel;

+ (void)logRect:(CGRect)rect withDescription:(NSString*)description;
+ (void)logPoint:(CGPoint)point withDescription:(NSString*)description;
+ (void)logSize:(CGSize)size withDescription:(NSString*)description;

+ (void)removeShadowsFromWebView:(UIWebView *)webView;

@end

CGRect CalcRectWithBorder(CGRect rectInitial, int iBorderSize);
CGRect CalcBoundsFromFrame(CGRect rectFrame);
CGRect CalcRectBiggerThanRect(CGRect rectInitial, float dWidth, float dHeight);
