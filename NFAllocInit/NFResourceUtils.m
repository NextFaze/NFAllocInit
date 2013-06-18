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

+ (BOOL)deleteImage:(NSString *)fileName
{
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    NSError *fileError;
    NSString *filePath = [[self imagesPath] stringByAppendingPathComponent:fileName];
    BOOL didDeleteFile = [fileManager removeItemAtPath:filePath error:&fileError];
    
    if (fileError) {
        NFLog(@"ERROR: %@", fileError.localizedDescription);
    }
    
    return didDeleteFile;
}

+ (BOOL)fileExistsInMainBundle:(NSString *)fileName ofType:(NSString *)fileExtension
{
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:fileExtension];
    return (path != nil);
}

+ (NSArray *)arrayFromFile:(NSString *)fileName
{
    NSError *error;
    NSString *path = [[NSBundle mainBundle] pathForResource:[fileName stringByDeletingPathExtension] ofType:[fileName pathExtension]];
    NSString *stringContents = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
    NSArray *array = [stringContents componentsSeparatedByString:@"\n"];
    
    if (error) {
        NFLog(@"ERROR: %@", error);
    }
    
    return array;
}

+ (BOOL)isValidEmailAddress:(NSString *)emailAddress
{
    // source: http://stackoverflow.com/a/3638271 
    BOOL stricterFilter = YES; // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
    NSString *stricterFilterString = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSString *laxString = @".+@.+\\.[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:emailAddress];
}

@end
