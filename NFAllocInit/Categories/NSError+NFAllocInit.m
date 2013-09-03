//
//  NSError+NFAllocInit.m
//  NFAllocInit
//
//  Created by Ricardo Santos on 4/09/13.
//  Copyright (c) 2013 NextFaze SD. All rights reserved.
//

#import "NSError+NFAllocInit.h"

@implementation NSError (NFAllocInit)

+ (NSError *)errorWithReason:(NSString *)reason andDescription:(NSString *)description andDomain:(NSString *)domain
{
    return [NSError errorWithReason:reason andDescription:description andDomain:domain code:0];
}

+ (NSError *)errorWithReason:(NSString *)reason andDescription:(NSString *)description andDomain:(NSString *)domain code:(NSInteger)code
{
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    if (reason.length) userInfo[NSLocalizedFailureReasonErrorKey] = reason;
    if (description.length) userInfo[NSLocalizedDescriptionKey] = description;
    
    return [NSError errorWithDomain:domain code:code userInfo:userInfo];
}

@end
