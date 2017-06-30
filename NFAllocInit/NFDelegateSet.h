//
//  NFDelegateSet.h
//  NextFaze
//
//  Created by Andrew Williams on 11/01/11.
//  Copyright 2011 NextFaze. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NFDelegateSet : NSObject {
	NSMutableSet *set;  // delegate set
}

- (void)addDelegate:(nullable id)delegate;
- (void)removeDelegate:(nullable id)delegate;
- (NSArray *)list;

@end

NS_ASSUME_NONNULL_END
