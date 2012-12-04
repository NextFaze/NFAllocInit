//
//  NFResourceUtils.h
//
//  Copyright 2012 NextFaze. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    FileTypeImage,
    FileTypeVideo,
    FileTypePDF,
    FileTypePlist, // FileTypeXML ?
    FileTypeJson,
    FileTypeText,
    FileTypeUnknown
} FileType;

@interface NFResourceUtils : NSObject

+ (FileType)determineFileType:(NSString *)fileName;

@end
