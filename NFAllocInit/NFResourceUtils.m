//
//  NFResourceUtils.m
//
//  Copyright 2012 NextFaze. All rights reserved.
//

#import "NFResourceUtils.h"

#define STR_APP_EXTENSION	@".app"

@implementation NFResourceUtils

+ (FileType)determineFileType:(NSString*)fileName
{
    FileType result = FileTypeUnknown;
    
	NSString* extension = [[fileName pathExtension] lowercaseString];
    	
    if  ([extension isEqualToString:@"pdf"])
        result = FileTypePDF;
    else if ([extension isEqualToString:@"jpg"] ||
        [extension isEqualToString:@"jpeg"])
        result = FileTypeJPG;
    else if ([extension isEqualToString:@"png"])
        result = FileTypePNG;
    else if ([extension isEqualToString:@"mov"] ||
             [extension isEqualToString:@"m4v"] ||
             [extension isEqualToString:@"avi"] ||
             [extension isEqualToString:@"mp4"] ||
             [extension isEqualToString:@"mpg"] ||
             [extension isEqualToString:@"mpeg"])
        result = FileTypeVideo;
    else if ([extension isEqualToString:@"plist"])
        result = FileTypePlist;
    else if ([extension isEqualToString:@"txt"])
        result = FileTypeText;
    else if ([extension isEqualToString:@"json"])
        result = FileTypeJson;
    else
		result = FileTypeUnknown;

    return result;
}

+ (NSString *)documentPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    return documentsDirectory;
}

+ (NSString *)imagesPath
{
    NSString *documentsDirectory = [self documentPath];
    documentsDirectory = [documentsDirectory stringByAppendingPathComponent:@"photos"];
    
    NSError *error;
    [[NSFileManager defaultManager] createDirectoryAtPath:documentsDirectory withIntermediateDirectories:YES attributes:nil error:&error];
    
    return documentsDirectory;
}

+ (void)saveImage:(UIImage *)image withFileName:(NSString *)fileName
{
    NSString *docPath = [self imagesPath];
    
    FileType fileType = [self determineFileType:fileName];
    
    if (fileType == FileTypePNG) {
        [UIImagePNGRepresentation(image) writeToFile:[docPath stringByAppendingPathComponent:fileName] options:NSAtomicWrite error:nil];
    } else if (fileType == FileTypeJPG) {
        [UIImageJPEGRepresentation(image, 1.0) writeToFile:[docPath stringByAppendingPathComponent:fileName] options:NSAtomicWrite error:nil];
    } else {
        NSLog(@"Image Save Failed: Use PNG or JPG");
    }
}

+ (UIImage *)loadImage:(NSString *)fileName
{
    NSString *fullImagePath = [[self imagesPath] stringByAppendingPathComponent:fileName];
    return [UIImage imageWithContentsOfFile:fullImagePath];
}


@end
