//
//  NSArray+NFAllocInit.h
//
//  Created by Andrew Williams FTW on 19/09/12.
//  Copyright (c) 2012 NextFaze. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

// informal NSComparisonMethods
@protocol NFAllocInitComparisonMethods <NSObject>
- (BOOL)isEqualTo:(nullable id)object;
- (BOOL)isGreaterThan:(nullable id)object;
- (BOOL)isLessThan:(nullable id)object;
@end

typedef BOOL (^NFAllocInitTestBlock)(id _Nullable object);
typedef id _Nonnull (^NFAllocInitObjectBlock)(id object);
typedef id<NFAllocInitComparisonMethods> _Nonnull (^NFAllocInitComparableObjectBlock)(id _Nullable object);

@interface NSArray (NFAllocInit)
- (id)objectAtIndexFTW:(NSUInteger)index;
- (NSArray *)shuffle;

// inspired by ruby Enumerable
- (BOOL)all:(NFAllocInitTestBlock)block;
- (BOOL)any:(NFAllocInitTestBlock)block;
- (NSArray *)collect:(NFAllocInitObjectBlock)block;
- (NSArray *)map:(NFAllocInitObjectBlock)block;
- (void)cycle:(int)count block:(NFAllocInitObjectBlock)block;
- (nullable id)detect:(NFAllocInitTestBlock)block;
- (nullable id)reject:(NFAllocInitTestBlock)block;
- (nullable id)find:(NFAllocInitTestBlock)block;
- (nullable id)findByKey:(NSString *)key value:(id)value;
- (NSArray *)findAll:(NFAllocInitTestBlock)block;
- (NSArray *)select:(NFAllocInitTestBlock)block;
- (NSArray *)first:(int)count;
- (NSDictionary *)groupBy:(NFAllocInitObjectBlock)block;
- (BOOL)one:(NFAllocInitTestBlock)block;
- (NSArray *)partition:(NFAllocInitTestBlock)block;
- (NSArray *)sortBy:(NFAllocInitComparableObjectBlock)block;

@end

NS_ASSUME_NONNULL_END
