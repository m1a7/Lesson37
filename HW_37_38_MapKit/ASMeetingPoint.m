//
//  ASMeetingPoint.m
//  HW_37_38_MapKit
//
//  Created by MD on 14.07.15.
//  Copyright (c) 2015 MD. All rights reserved.
//

#import "ASMeetingPoint.h"
#import "UIImage+imageWithImage.h"
#import <MapKit/MapKit.h>

@implementation ASMeetingPoint
#define ARC4RANDOM_MAX      0x100000000



-(void) dealloc {

    self.image = nil;
}

-(instancetype) initWithNameBuild:(NSString*)nameBuild image:(NSString*)nameImage location:(CLLocationCoordinate2D) coordinate {

    self = [super init];
    
    if (self) {
     

        
    
      self.rating           = [self randomFloatBetween:1 andLargerFloat:10];
      self.capacityBuilding = [self randomIntegerBetween:10 andLargerFloat:200];
    
      self.coordinate       = coordinate;

      self.title    = [NSString stringWithFormat:@"%@",nameBuild];
      self.subtitle = [NSString stringWithFormat:@"Рейтинг - %.2f",self.rating];
      self.image    = [UIImage imageNamed:[NSString stringWithFormat:@"TypesInstitution/%@",nameImage]];
      self.image    = [UIImage imageWithImage:self.image scaledToSize:CGSizeMake(48, 48)];
      self.arrayStudents      = [[NSMutableArray alloc] init];
      self.arrayOverlayCircle = [[NSMutableArray alloc] init];
 
      MKCircle *circle1 = [MKCircle circleWithCenterCoordinate:self.coordinate radius:500];
      MKCircle *circle2 = [MKCircle circleWithCenterCoordinate:self.coordinate radius:1000];
      MKCircle *circle3 = [MKCircle circleWithCenterCoordinate:self.coordinate radius:1500];

      self.arrayOverlayCircle = [NSMutableArray arrayWithObjects: circle1,circle2,circle3, nil];
        self.arrayPolyline = [[NSMutableArray alloc]init];
  
      NSLog(@"\n\n\nASMeetingPoint instancetype \n\nTitle = %@\nImage = %@\n\n",self.title,nameImage);
    }
    
  return self;
}

#pragma mark - Generate Random Number

-(double)randomFloatBetween:(double)num1 andLargerFloat:(double)num2
{
    double range = num2 - num1;
    double val = ((double)arc4random() / ARC4RANDOM_MAX) * range + num1;
    
    return val;
}

-(NSInteger)randomIntegerBetween:(NSInteger)num1 andLargerFloat:(NSInteger)num2
{
    NSInteger range = num2 - num1;
    NSInteger val = ((NSInteger)arc4random() / ARC4RANDOM_MAX) * range + num1;
    
    return val;
}



@end
