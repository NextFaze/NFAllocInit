//
//  NSObject+NFAllocInit_Properties.h
//  NFAllocInit
//
//  Created by Andrew Williams on 20/02/2014.
//  Copyright (c) 2014 NextFaze SD. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (NFAllocInit_Properties)

// return a list of NFProperty objects
+ (NSArray *)properties;

@end

NS_ASSUME_NONNULL_END
