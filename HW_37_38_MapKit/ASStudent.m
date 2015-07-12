//
//  ASStudent.m
//  HW_37_38_MapKit
//
//  Created by MD on 11.07.15.
//  Copyright (c) 2015 MD. All rights reserved.
//

#import "ASStudent.h"
#import <MapKit/MapKit.h>

@implementation ASStudent


#define ARC4RANDOM_MAX      0x100000000


-(instancetype) initWithName:(NSString*)name andFamaly:(NSString*)famaly andUserLocation:(CLLocation *)newLocation{
    self = [super init];
    
    if (self) {
        
        NSCalendar       *calendar  = [NSCalendar currentCalendar];
        NSDateComponents *comps     = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:[NSDate date]];
  
        NSString         *stringOfBirth = [NSString stringWithFormat:@"%ld",[comps year]-((arc4random()%(60-18))+18)];

        self.firstname    = name;
        self.lastname     = famaly;
        self.dateOfBirth  = stringOfBirth;
        self.genderEnum   = (arc4random() % (int) ASFemale);
        
       
        // От координат пользователя будем выставлять студентов
        CLLocationCoordinate2D coordinateUser2d = newLocation.coordinate;
        
        double latitudeUser  = coordinateUser2d.latitude;
        double longitudeUser = coordinateUser2d.longitude;

    
        // Координаты студентов
        CLLocationCoordinate2D coordinateStudent2d;
        

        
       // double  rangeLatitude   =  latitudeUser + ((arc4random()%(toNumber-fromNumber))+fromNumber);
       // double  rangeLongitude  =  longitudeUser - 2;
        
      
       // double latitudeStudent   =    ((double)arc4random() / ARC4RANDOM_MAX) + rangeLatitude+2;
       // double longitudeStudent  =    ((double)arc4random() / ARC4RANDOM_MAX) + rangeLongitude+2;
        
     
        double latitudeStudent   =   latitudeUser + [self randomFloatBetween:-0.08 andLargerFloat:0.05];
        double longitudeStudent  =   longitudeUser + [self randomFloatBetween:-0.08 andLargerFloat:0.05];
        
        
        coordinateStudent2d.latitude  = latitudeStudent;
        coordinateStudent2d.longitude = longitudeStudent;

        
      
        self.coordinate = coordinateStudent2d;
        
        
        self.title    = [NSString stringWithFormat:@"%@ %@",name,famaly];
        self.subtitle = [NSString stringWithFormat:@"%@",stringOfBirth];
        
        NSLog(@" latitudeStudent = %f   longitudeStudent = %f",latitudeStudent,longitudeStudent);
        //NSLog(@"\tName = %@     \tFamaly = %@     \tDate = %@  |",name,  famaly, string);
    }
    return self;
}

-(double)randomFloatBetween:(double)num1 andLargerFloat:(double)num2
{
    double range = num2 - num1;
    double val = ((double)arc4random() / ARC4RANDOM_MAX) * range + num1;
    
    return val;
}

@end
