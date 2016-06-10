//
//  NSString+NFAllocInit.h
//
//  Created by Andreas Wulf on 4/10/12.
//  Copyright (c) 2012 NextFaze. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (NFAllocInit)

- (NSString *)stringByURLEncoding;
- (NSString *)md5;
- (BOOL)isBlank;
- (BOOL)isNotBlank;
- (NSString *)trim;
- (NSArray<NSString *> *)matchesForRegex:(NSString *)regex options:(NSRegularExpressionOptions)options;

@end

NS_ASSUME_NONNULL_END
