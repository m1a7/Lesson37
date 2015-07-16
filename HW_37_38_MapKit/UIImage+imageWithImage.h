//
//  UIImage+imageWithImage.h
//  HW_37_38_MapKit
//
//  Created by MD on 16.07.15.
//  Copyright (c) 2015 MD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (imageWithImage)

+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;

@end
