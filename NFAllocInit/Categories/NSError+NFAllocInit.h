//
//  NSError+NFAllocInit.h
//  NFAllocInit
//
//  Created by Ricardo Santos on 4/09/13.
//  Copyright (c) 2013 NextFaze SD. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSError (NFAllocInit)

+ (NSError *)errorWithReason:(NSString *)reason andDescription:(NSString *)description andDomain:(NSString *)domain;
+ (NSError *)errorWithReason:(NSString *)reason andDescription:(NSString *)description andDomain:(NSString *)domain code:(NSInteger)code;

@end

NS_ASSUME_NONNULL_END
