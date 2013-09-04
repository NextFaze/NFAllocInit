//
//  NFDelegateSet.m
//  NextFaze
//
//  Created by Andrew Williams on 11/01/11.
//  Copyright 2011 NextFaze. All rights reserved.
//

#import "NFDelegateSet.h"

@implementation NFDelegateSet

// returns an mutable set (non retaining)
- (NSMutableSet *)nonRetainingSet {
	//Default callbacks
	CFSetCallBacks callbacks = kCFTypeSetCallBacks;
	
	//Disable retain and release
	callbacks.retain = NULL;
	callbacks.release = NULL;
	
	NSMutableSet *s = (NSMutableSet *)CFBridgingRelease(CFSetCreateMutable(kCFAllocatorDefault, 0, &callbacks));

	return s;
}

#pragma mark -

- (id)init {
	if(self = [super init]) {
		set = [self nonRetainingSet];
	}
	return self;
}


#pragma mark -

- (void)addDelegate:(id)delegate {
	if(![NSThread isMainThread]) {
		[self performSelectorOnMainThread:@selector(addDelegate:) withObject:delegate waitUntilDone:YES];
		return;
	}
	
	@synchronized(self) {
		//NFLog(@"adding delegate: %@", delegate);
		[set addObject:delegate];
	}
}

- (void)removeDelegate:(id)delegate {
	if(![NSThread isMainThread]) {
		[self performSelectorOnMainThread:@selector(removeDelegate:) withObject:delegate waitUntilDone:YES];
		return;
	}

	@synchronized(self) {
		//NFLog(@"removing delegate: %@", delegate);
		[set removeObject:delegate];
	}
}

- (NSArray *)list {
	@synchronized(self) {
		return [set allObjects];
	}
}

@end
