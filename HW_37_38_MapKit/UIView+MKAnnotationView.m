//
//  UIView+MKAnnotationView.m
//  HW_37_38_MapKit
//
//  Created by MD on 13.07.15.
//  Copyright (c) 2015 MD. All rights reserved.
//
#import "UIView+MKAnnotationView.h"
#import <MapKit/MKAnnotationView.h>

@implementation UIView (MKAnnotationView)

- (MKAnnotationView*) superAnnotationView {
    
    if ([self isKindOfClass:[MKAnnotationView class]]) {
        return (MKAnnotationView*)self;
    }
    
    if (!self.superview) {
        return nil;
    }
    
    return [self.superview superAnnotationView];
    
}

@end
