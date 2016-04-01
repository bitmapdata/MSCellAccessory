//
//  UIView+AccessViewController.m
//  MSCellAccessory
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
- (UIViewController *)ms_firstAvailableUIViewController {
    // convenience function for casting and to "mask" the recursive function
    return (UIViewController *)[self ms_traverseResponderChainForUIViewController];
}

- (id)ms_traverseResponderChainForUIViewController {
    id nextResponder = [self nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]]) {
        return nextResponder;
    } else if ([nextResponder isKindOfClass:[UIView class]]) {
        return [nextResponder ms_traverseResponderChainForUIViewController];
    } else {
        return nil;
    }
}
@end
