//
//  ImageUtils.h
//  Toyota-Showroom-iPad
//
//  Created by Wade on 24/05/11.
//  Copyright 2011 NextFaze. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NFImageUtils : NSObject

+ (CGRect) centreWithinRect:(CGRect)rectOuter width:(float)fWidth height:(float)fHeight;
+ (UIImage *)imageWithContentsOfFile:(NSString *)path size:(CGSize)size;

@end
