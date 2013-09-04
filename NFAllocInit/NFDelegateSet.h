//
//  NFDelegateSet.h
//  NextFaze
//
//  Created by Andrew Williams on 11/01/11.
//  Copyright 2011 NextFaze. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NFDelegateSet : NSObject {
	NSMutableSet *set;  // delegate set
}

- (void)addDelegate:(id)delegate;
- (void)removeDelegate:(id)delegate;
- (NSArray *)list;

@end
