//
//  CustomRadius.m
//  HW_37_38_MapKit
//
//  Created by MD on 18.07.15.
//  Copyright (c) 2015 MD. All rights reserved.
//

#import "CustomRadiusTableView.h"
#import <QuartzCore/QuartzCore.h>


@implementation CustomRadiusTableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.layer.cornerRadius = 10.f;
        self.backgroundColor = [UIColor grayColor];
        self.alpha = 0.5;
        
        
        UILabel *lb1 = [[UILabel alloc]init];
        UILabel *lb2 = [[UILabel alloc]init];
        UILabel *lb3 = [[UILabel alloc]init];
        
        NSArray* array = [NSArray arrayWithObjects:lb1,lb2,lb3, nil];
        
        float y = 0;
        
        for (UILabel* lb in array) {
            
            lb.textColor = [UIColor redColor];
            lb.text = @"Radius = ";
            lb.frame = CGRectMake(frame.origin.x+5, y, frame.size.width, 23);
            lb.alpha = 1.f;
            y += CGRectGetHeight(lb.frame);
        }
        
        
        self.labelRadius1 = lb1;
        self.labelRadius2 = lb2;
        self.labelRadius3 = lb3;
        

        
        [self addSubview:self.labelRadius1];
        [self addSubview:self.labelRadius2];
        [self addSubview:self.labelRadius3];
        
    }
    return self;
}


@end
