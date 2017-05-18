//
//  UIResponder+NFAllocInit.h
//  NFAllocInit
//
//  Created by swoolcock on 18/5/17.
//  Copyright © 2017 NextFaze SD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIResponder (NFAllocInit)

+ (void)resignAnyFirstResponder;

@end

NS_ASSUME_NONNULL_END
