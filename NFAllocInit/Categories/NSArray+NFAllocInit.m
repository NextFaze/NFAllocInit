//
//  NSArray+FTW.m
//
//  Created by Andrew Williams on 19/09/12.
//  Copyright (c) 2012 NextFaze. All rights reserved.
//

#import "NSArray+NFAllocInit.h"

@implementation NSArray (NFAllocInit)

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

- (BOOL)all:(NFAllocInitTestBlock)block {
    for(id object in self) {
        BOOL result = block(object);
        if(!result) return NO;
    }
    return YES;
}

- (BOOL)any:(NFAllocInitTestBlock)block {
    for(id object in self) {
        BOOL result = block(object);
        if(result) return YES;
    }
    return NO;
}

- (NSArray *)collect:(NFAllocInitObjectBlock)block {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:self.count];
    for(id object in self) {
        id result = block(object);
        if(result == nil)
            result = [NSNull null];
        [array addObject:result];
    }
    return array;
}

- (NSArray *)map:(NFAllocInitObjectBlock)block {
    return [self collect:block];
}

- (void)cycle:(int)count block:(NFAllocInitObjectBlock)block {
    while(count-- > 0) {
        for(id object in self)
            block(object);
    }
}

- (id)detect:(NFAllocInitTestBlock)block {
    for(id object in self) {
        if(block(object))
            return object;
    }
    return nil;
}

- (id)find:(NFAllocInitTestBlock)block {
    return [self detect:block];
}

- (id)findByKey:(NSString *)key value:(id)value {
    return [self find:^BOOL(id object) {
        @try {
            id objectValue = [object valueForKey:key];
            return [objectValue isEqual:value];
        } @catch(NSException *e) {
            return false;
        }
    }];
}

- (id)reject:(NFAllocInitTestBlock)block {
    NSMutableArray *array = [NSMutableArray array];
    for(id object in self) {
        if(!block(object))
            [array addObject:object];
    }
    return array;
}

- (NSArray *)findAll:(NFAllocInitTestBlock)block {
    NSMutableArray *array = [NSMutableArray array];
    for(id object in self) {
        if(block(object))
            [array addObject:object];
    }
    return array;
}

- (NSArray *)select:(NFAllocInitTestBlock)block {
    return [self findAll:block];
}

- (NSArray *)first:(int)count {
    NSMutableArray *array = [NSMutableArray array];
    for(int i = 0; i < count && i < self.count; i++) {
        [array addObject:[self objectAtIndex:i]];
    }
    return array;
}

// Groups the collection by result of the block. Returns a hash where the keys are the
// evaluated result from the block and the values are arrays of elements in the collection that correspond to the key.
- (NSDictionary *)groupBy:(NFAllocInitObjectBlock)block {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    for(id object in self) {
        id key = block(object);
        if(key == nil) key = [NSNull null];
        
        NSMutableArray *array = [dict objectForKey:key];
        if(array == nil) {
            array = [NSMutableArray arrayWithObject:object];
            [dict setObject:array forKey:key];
        }
        else {
            [array addObject:object];
        }
    }
    return dict;
}

// Passes each element of the collection to the given block. The method returns true if the block returns true exactly once.
- (BOOL)one:(NFAllocInitTestBlock)block {
    int count = 0;
    for(id object in self) {
        if(block(object)) {
            if(++count > 1)
                return NO;
        }
    }
    return count == 1;
}

// Returns two arrays, the first containing the elements of enum for which the block evaluates to true, the second containing the rest.
- (NSArray *)partition:(NFAllocInitTestBlock)block {
    NSMutableArray *arrayTrue = [NSMutableArray array];
    NSMutableArray *arrayFalse = [NSMutableArray array];
    NSMutableArray *partition = [NSMutableArray arrayWithObjects:arrayTrue, arrayFalse, nil];

    for(id object in self) {
        if(block(object)) {
            [arrayTrue addObject:object];
        } else {
            [arrayFalse addObject:object];
        }
    }
    return partition;
}

- (NSArray *)sortBy:(NFAllocInitComparableObjectBlock)block {
    NSMutableArray *tuples = [NSMutableArray arrayWithCapacity:self.count];
    for(id object in self) {
        id value = block(object);
        if(value == nil)
            value = [NSNull null];
        
        [tuples addObject:@[object, value]];
    }
    
    [tuples sortUsingComparator:^NSComparisonResult(NSArray *obj1, NSArray *obj2) {
        id<NFAllocInitComparisonMethods> value1 = [obj1 objectAtIndex:1];
        id<NFAllocInitComparisonMethods> value2 = [obj2 objectAtIndex:1];
        
        if([value1 isKindOfClass:[NSNull class]])
            value1 = nil;
        if([value2 isKindOfClass:[NSNull class]])
            value2 = nil;
        
        return (value1 == value2 ? NSOrderedSame :
                value1 == nil && value2 != nil ? NSOrderedAscending :
                value1 != nil && value2 == nil ? NSOrderedDescending :
                [value1 isLessThan:value2] ? NSOrderedAscending :
                [value1 isGreaterThan:value2] ? NSOrderedDescending : NSOrderedSame);
    }];
    
    return [tuples collect:^id(NSArray *object) {
        return [object objectAtIndex:0];
    }];
}

@end
