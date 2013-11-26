//
//  NSString+Additions.h
//
//  Created by Andreas Wulf on 4/10/12.
//  Copyright (c) 2012 NextFaze. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (NFAllocInit)

- (NSString *)stringByURLEncoding;
- (NSString *)md5;
- (BOOL)isBlank;
- (BOOL)isNotBlank;

@end
