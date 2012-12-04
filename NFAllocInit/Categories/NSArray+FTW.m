//
//  NSArray+FTW.m
//
//  Created by Andrew Williams on 19/09/12.
//  Copyright (c) 2012 NextFaze. All rights reserved.
//

#import "NSArray+FTW.h"

@implementation NSArray (FTW)

- (id)firstObject {
    return self.count == 0 ? nil : [self objectAtIndex:0];
}

- (id)objectAtIndexFTW:(NSUInteger)index {
    return index < self.count ? [self objectAtIndex:index] : nil;
}

@end
