//
//  NSData+NFAllocInit.h
//
//  Created by Andreas Wulf.
//  Copyright 2012 NextFaze. All rights reserved.
//

NS_ASSUME_NONNULL_BEGIN

@interface NSData (NFAllocInit)

- (NSString *)md5;
- (NSString *)encodeToBase64;
- (NSString *)hexadecimal;

@end

NS_ASSUME_NONNULL_END
