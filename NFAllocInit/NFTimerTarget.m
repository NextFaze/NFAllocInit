//
//  NFTimerTarget.m
//  NFAllocInit
//
//  Created by Andrew Williams on 3/02/2014.
//  Copyright (c) 2014 NextFaze SD. All rights reserved.
//

#import "NFTimerTarget.h"

@interface NFTimerTarget ()
@property (nonatomic, weak) id<NFTimerTargetDelegate> realTarget;
@end

@implementation NFTimerTarget

+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)timeInterval target:(id<NFTimerTargetDelegate>)target repeats:(BOOL)repeats {
    return [self scheduledTimerWithTimeInterval:timeInterval target:target userInfo:nil repeats:repeats];
}

+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)timeInterval target:(id<NFTimerTargetDelegate>)target userInfo:(NSDictionary *)userInfo repeats:(BOOL)repeats {
    NFTimerTarget *timerTarget = [[NFTimerTarget alloc] init];
    timerTarget.realTarget = target;
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:timeInterval target:timerTarget selector:@selector(handleTimer:) userInfo:userInfo repeats:repeats];
    return timer;
}

- (void)handleTimer:(NSTimer *)timer {
    [self.realTarget handleTimer:timer];
}

@end
