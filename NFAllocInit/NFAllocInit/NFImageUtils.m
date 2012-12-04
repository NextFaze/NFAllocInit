//
//  ImageUtils.m
//  Toyota-Showroom-iPad
//
//  Created by Wade on 24/05/11.
//  Copyright 2011 NextFaze. All rights reserved.
//

#import "NFImageUtils.h"
#import "UIImage+Resize.h"
#import "JNGImage.h"
#import <ImageIO/ImageIO.h>
#import "ViewHelper.h"

@implementation NFImageUtils

+ (CGRect)centreWithinRect:(CGRect)rectOuter width:(float)fWidth height:(float)fHeight
{
	CGRect rectOutput;
	
	// What scale does this image fit in?
	float fScaleX = rectOuter.size.width / fWidth;
	float fScaleY = rectOuter.size.height / fHeight;
	
	// Determine the smallest scale (otherwise the other axis won't fit)
	float fScaleActual = fScaleX;
	if (fScaleY < fScaleActual)
		fScaleActual = fScaleY;
	
	// Determine the final size and position
	float fScaledWidth = fWidth * fScaleActual;
	float fScaledHeight = fHeight * fScaleActual;
	
	float fRelativeLeft = (rectOuter.size.width - fScaledWidth) / 2;
	float fRelativeTop = (rectOuter.size.height - fScaledHeight) / 2;
	
	float fAbsoluteLeft = rectOuter.origin.x + fRelativeLeft;
	float fAbsoluteTop = rectOuter.origin.y + fRelativeTop;
	
	rectOutput = CGRectMake(fAbsoluteLeft, fAbsoluteTop, fScaledWidth, fScaledHeight);
	
	return rectOutput;
}

+ (UIImage *)imageWithContentsOfFile:(NSString *)path size:(CGSize)size {
    NSData *data = [[NSFileManager defaultManager] contentsAtPath:path];
    if(data == nil) return nil;
    
    if([[path lowercaseString] hasSuffix:@".jng"]) {
        return [[JNGImage imageWithData:data] image];
    } else {
        
        if (NO) {
            //cocoanetics
            //http://www.cocoanetics.com/2011/10/avoiding-image-decompression-sickness/
            
            NSURL *url = [[[NSURL alloc] initFileURLWithPath:path] autorelease];
            
            NSDictionary *dict = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:YES]
                                                             forKey:(id)kCGImageSourceShouldCache];
            
            CGImageSourceRef source = CGImageSourceCreateWithURL((CFURLRef)url, NULL);
            CGImageRef cgImage = CGImageSourceCreateImageAtIndex(source, 0, (CFDictionaryRef)dict);
            
            UIImage *retImage = [UIImage imageWithCGImage:cgImage];
            CGImageRelease(cgImage);
            CFRelease(source);
            
            return retImage;
            
        }
        else if (NO) {
            //cocoanetics modified for resizing
            
            NSURL *url = [[[NSURL alloc] initFileURLWithPath:path] autorelease];
            
            NSDictionary *dict = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:YES]
                                                             forKey:(id)kCGImageSourceShouldCache];
            
            CGImageSourceRef source = CGImageSourceCreateWithURL((CFURLRef)url, NULL);
            CGImageRef cgImage = CGImageSourceCreateImageAtIndex(source, 0, (CFDictionaryRef)dict);
            
            UIImage *retImage = nil;
            
            if (size.width == 0 && size.height == 0) {
                //NFLog(@"No resize required (%@)", path);
                
                //retImage = [UIImage imageWithCGImage:cgImage];
                size.width = CGImageGetWidth(cgImage);
                size.height = CGImageGetHeight(cgImage);
            }
            
            
            {
                //NFLog(@"Resize required (%@)", path);
                // make a bitmap context of a suitable size to draw to, forcing decode
                size_t width = size.width;
                size_t height = size.height;
                unsigned char *imageBuffer = (unsigned char *)malloc(width*height*4);
                
                CGColorSpaceRef colourSpace = CGColorSpaceCreateDeviceRGB();
                
                CGContextRef imageContext =
                CGBitmapContextCreate(imageBuffer,
                                      width,
                                      height,
                                      8,
                                      width*4,
                                      colourSpace,
                                      kCGImageAlphaPremultipliedFirst | kCGBitmapByteOrder32Little
                                      );
                
                CGColorSpaceRelease(colourSpace);
                
                //if (self.scaleToFit) {
                // Set the quality level to use when rescaling
                CGContextSetInterpolationQuality(imageContext, kCGInterpolationLow);
                //}
                
                // draw the image to the context, release it
                CGContextDrawImage(imageContext, CGRectMake(0, 0, width, height), cgImage);
                CGImageRef outputImage = CGBitmapContextCreateImage(imageContext);
                
                retImage = [UIImage imageWithCGImage:outputImage];
                
                CGContextRelease(imageContext);
                free(imageBuffer);
            }

            
            CGImageRelease(cgImage);
            CFRelease(source);
            
            return retImage;
            
        }
        else if (NO) {
            //stackoverflow adapted
            //http://stackoverflow.com/questions/1815476/cgimage-uiimage-lazily-loading-on-ui-thread-causes-stutter
            
            
            NSString *fileExtension = [path pathExtension];
            //NFLog(@"file extension: %@", fileExtension);
            
            NSData *data = [NSData dataWithContentsOfFile:path];
            CFDataRef imageData = (CFDataRef)data;
            
            // get a data provider referencing the relevant file
            CGDataProviderRef dataProvider = CGDataProviderCreateWithCFData(imageData);
            
            // use the data provider to get a CGImage; release the data provider
            CGImageRef image = nil;
            
            // TODO: make this file type checking bullet proof
            if ([fileExtension isEqualToString:@"jpg"] || [fileExtension isEqualToString:@"jpeg"]) {
                image = CGImageCreateWithJPEGDataProvider(dataProvider, NULL, NO, kCGRenderingIntentDefault);
            }
            else if ([fileExtension isEqualToString:@"png"]) {
                image = CGImageCreateWithPNGDataProvider(dataProvider, NULL, NO, kCGRenderingIntentDefault);
            }
                        
            // make a bitmap context of a suitable size to draw to, forcing decode
            size_t width = (size.width == 0) ? CGImageGetWidth(image) : size.width;
            size_t height = (size.height == 0) ? CGImageGetHeight(image) : size.height;
            
            CGDataProviderRelease(dataProvider);

            NFLog(@"width: %zu, height: %zu", width, height);
            [ViewHelper logSize:size withDescription:@"size"];
            NFLog(@"image width: %zd, height: %zd", CGImageGetWidth(image), CGImageGetHeight(image));
            
            unsigned char *imageBuffer = (unsigned char *)malloc(width*height*4);
            
            CGColorSpaceRef colourSpace = CGColorSpaceCreateDeviceRGB();
            
            CGContextRef imageContext =
            CGBitmapContextCreate(imageBuffer,
                                  width,
                                  height,
                                  8,
                                  width*4,
                                  colourSpace,
                                  kCGImageAlphaPremultipliedFirst | kCGBitmapByteOrder32Little
                                  );
            
            CGColorSpaceRelease(colourSpace);
            
            //if (self.scaleToFit) {
            // Set the quality level to use when rescaling
            CGContextSetInterpolationQuality(imageContext, kCGInterpolationLow);
            //}
            
            // draw the image to the context, release it
            CGContextDrawImage(imageContext, CGRectMake(0, 0, width, height), image);
            CGImageRelease(image);
            
            // now get an image ref from the context
            CGImageRef outputImage = CGBitmapContextCreateImage(imageContext);
            
            UIImage *theImage = [UIImage imageWithCGImage:outputImage];
            
            // clean up
            CGImageRelease(outputImage);
            CGContextRelease(imageContext);
            free(imageBuffer);
            
            //[pool release];
            
            return theImage;
        }
        else {
            //standard (blocks main thread)
            return [UIImage imageWithData:data];
        }
    }
}

@end
