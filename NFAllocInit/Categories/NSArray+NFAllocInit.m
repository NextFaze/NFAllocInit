//
//  NSArray+FTW.m
//
//  Created by Andrew Williams on 19/09/12.
//  Copyright (c) 2012 NextFaze. All rights reserved.
//

#import "NSArray+NFAllocInit.h"

@implementation NSArray (NFAllocInit)

- (id)firstObject {
    return self.count == 0 ? nil : [self objectAtIndex:0];
}

- (id)objectAtIndexFTW:(NSUInteger)index {
    return index < self.count ? [self objectAtIndex:index] : nil;
}

- (NSArray *)shuffle
{
    NSUInteger count = [self count];
    NSMutableArray *new = [NSMutableArray arrayWithArray:self];
    for (NSUInteger i = 0; i < count; ++i) {
        // Select a random element between i and end of array to swap with.
        NSInteger nElements = count - i;
        NSInteger n = (arc4random() % nElements) + i;
        [new exchangeObjectAtIndex:i withObjectAtIndex:n];
    }
    return new;
}

@end
