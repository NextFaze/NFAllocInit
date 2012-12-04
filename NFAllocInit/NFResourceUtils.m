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
        [extension isEqualToString:@"jpeg"] ||
        [extension isEqualToString:@"png"] ||
        [extension isEqualToString:@"bmp"] ||
        [extension isEqualToString:@"jng"] ||
        [extension isEqualToString:@"gif"])
        result = FileTypeImage;
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

@end
