//
//  NSArray+FTW.h
//
//  Created by Andrew Williams on 19/09/12.
//  Copyright (c) 2012 NextFaze. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (FTW)
- (id)firstObject;
- (id)objectAtIndexFTW:(NSUInteger)index;
- (NSArray *)shuffle;
@end
