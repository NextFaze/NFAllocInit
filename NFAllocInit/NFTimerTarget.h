//
//  NFTimerTarget.h
//  NFAllocInit
//
//  Created by Andrew Williams on 3/02/2014.
//  Copyright (c) 2014 NextFaze SD. All rights reserved.
//
//  a utility class to prevent retain loops when using NSTimer under ARC.
//  a 'NFTimerTarget' object is created to handle timer callbacks, which holds a weak reference to the target.
//  the target callback object should implement the NFTimerTargetDelegate protocol.

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol NFTimerTargetDelegate <NSObject>
- (void)handleTimer:(NSTimer *)timer;
@end

@interface NFTimerTarget : NSObject

+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)timeInterval target:(id<NFTimerTargetDelegate>)target repeats:(BOOL)repeats;
+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)timeInterval target:(id<NFTimerTargetDelegate>)target userInfo:(nullable NSDictionary *)userInfo repeats:(BOOL)repeats;

@end

NS_ASSUME_NONNULL_END
