//
//  UIView+NFAllocInit.m
//
//  Created by Andreas Wulf on 5/10/12.
//  Copyright (c) 2012 NextFaze. All rights reserved.
//

#import "UIView+NFAllocInit.h"

@implementation UIView (NFAllocInit)

- (void)printAllSubviews:(NSString*)indent
{
    NSLog(@"%@%@",indent,self);
    NSLog(@"%@(RESP %@)",indent,[self nextResponder]);
    for (UIView *subview in self.subviews) {
        [subview printAllSubviews:[NSString stringWithFormat:@"   %@",indent]];
    }
}

- (void)printAllSubviews
{
    NSLog(@"**** SUB VIEWS ****");
    [self printAllSubviews:@""];
    NSLog(@"**** ********* ****");
}

- (UIViewController*)findViewController
{
    id nextResponder = [self nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]]) {
        return  nextResponder;
    } else if (self.subviews.count) {
        for (UIView *subview in self.subviews) {
            id result = [subview findViewController];
            if (result) {
                return result;
            }
        }
    }
    return nil;
}


@end
