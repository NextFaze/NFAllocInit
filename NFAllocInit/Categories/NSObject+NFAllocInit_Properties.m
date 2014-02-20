//
//  NSObject+NFAllocInit_Properties.m
//  NFAllocInit
//
//  Created by Andrew Williams on 20/02/2014.
//  Copyright (c) 2014 NextFaze SD. All rights reserved.
//

#import "NSObject+NFAllocInit_Properties.h"
#import "NFProperty.h"

@implementation NSObject (NFAllocInit_Properties)

+ (NSArray *)properties {
    return [NFProperty propertiesFromClass:self];
}

@end
