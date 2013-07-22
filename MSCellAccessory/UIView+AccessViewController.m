//
//  UIView+AccessViewController.m
//  MSCellAccessoryDemo
//
//  Created by SHIM MIN SEOK on 13. 7. 22..
//  Copyright (c) 2013 SHIM MIN SEOK. All rights reserved.
//

#import "UIView+AccessViewController.h"

@implementation UIView (AccessViewController)
- (UIViewController *)viewController;
{
    id nextResponder = [self nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]]) {
        return nextResponder;
    } else {
        return nil;
    }
}
@end
