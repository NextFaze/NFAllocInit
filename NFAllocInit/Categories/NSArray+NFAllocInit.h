//
//  NSArray+NFAllocInit.h
//
//  Created by Andrew Williams FTW on 19/09/12.
//  Copyright (c) 2012 NextFaze. All rights reserved.
//

#import <Foundation/Foundation.h>

// informal NSComparisonMethods
@protocol NFAllocInitComparisonMethods <NSObject>
- (BOOL)isEqualTo:(id)object;
- (BOOL)isGreaterThan:(id)object;
- (BOOL)isLessThan:(id)object;
@end

typedef BOOL (^NFAllocInitTestBlock)(id object);
typedef id (^NFAllocInitObjectBlock)(id object);
typedef id<NFAllocInitComparisonMethods> (^NFAllocInitComparableObjectBlock)(id object);

@interface NSArray (NFAllocInit)
- (id)objectAtIndexFTW:(NSUInteger)index;
- (NSArray *)shuffle;

// inspired by ruby Enumerable
- (BOOL)all:(NFAllocInitTestBlock)block;
- (BOOL)any:(NFAllocInitTestBlock)block;
- (NSArray *)collect:(NFAllocInitObjectBlock)block;
- (NSArray *)map:(NFAllocInitObjectBlock)block;
- (void)cycle:(int)count block:(NFAllocInitObjectBlock)block;
- (id)detect:(NFAllocInitTestBlock)block;
- (id)reject:(NFAllocInitTestBlock)block;
- (id)find:(NFAllocInitTestBlock)block;
- (id)findByKey:(NSString *)key value:(id)value;
- (NSArray *)findAll:(NFAllocInitTestBlock)block;
- (NSArray *)select:(NFAllocInitTestBlock)block;
- (NSArray *)first:(int)count;
- (NSDictionary *)groupBy:(NFAllocInitObjectBlock)block;
- (BOOL)one:(NFAllocInitTestBlock)block;
- (NSArray *)partition:(NFAllocInitTestBlock)block;
- (NSArray *)sortBy:(NFAllocInitComparableObjectBlock)block;

@end


